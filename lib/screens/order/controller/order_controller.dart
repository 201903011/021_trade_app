import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimals/injection.dart';
import 'package:minimals/models/holding_model.dart';
import 'package:minimals/models/order_model.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/models/transaction_model.dart';
import 'package:minimals/screens/funds/controller/funds_controller.dart';
import 'package:minimals/screens/funds/repository/transaction_repository.dart';
import 'package:minimals/screens/holdings/controller/holding_controller.dart';
import 'package:minimals/screens/holdings/repository/holding_repository.dart';
import 'package:minimals/screens/holdings/repository/order_repository.dart';
import 'package:minimals/screens/holdings/repository/wallet_repository.dart';

class OrderController extends GetxController {
  late final StockModel stock;
  late final FundsMainController fundsController;
  final RxBool isBuy = true.obs;
  final RxBool isMarket = true.obs;
  final RxString errorMsg = ''.obs;
  final RxBool isSubmitting = false.obs;
  final RxDouble heldQuantity = 0.0.obs;
  final TextEditingController qtyCtrl = TextEditingController(text: '1');
  final TextEditingController limitPriceCtrl = TextEditingController();

  final _holdingRepo = getIt<HoldingRepository>();
  final _orderRepo = getIt<OrderRepository>();
  final _walletRepo = getIt<WalletRepository>();
  final _txnRepo = getIt<TransactionRepository>();

  RxDouble get availableBalance => fundsController.walletBalance;

  @override
  void onInit() {
    super.onInit();
    fundsController = Get.isRegistered<FundsMainController>() ? Get.find<FundsMainController>() : Get.put(FundsMainController());
    final args = Get.arguments as Map<String, dynamic>?;
    final symbol = args?['symbol'] as String? ?? StockModel.allStocks.first.symbol;
    final forceBuy = args?['isBuy'] as bool? ?? true;
    stock = StockModel.stockMap[symbol] ?? StockModel.allStocks.first;
    isBuy.value = forceBuy;
    _loadBalanceAndHolding();
  }

  Future<void> _loadBalanceAndHolding() async {
    await fundsController.reload();
    final h = await _holdingRepo.getHolding(stock.symbol);
    heldQuantity.value = h?.quantity ?? 0.0;
  }

  double get parsedQty => double.tryParse(qtyCtrl.text.trim()) ?? 0;

  double get liveOrderValue => double.parse((parsedQty * stock.lastPrice.value).toStringAsFixed(2));

  double get execPrice => isMarket.value ? stock.lastPrice.value : (double.tryParse(limitPriceCtrl.text.trim()) ?? 0);

  bool get hasSufficientBalance => fundsController.walletBalance.value >= double.parse((parsedQty * execPrice).toStringAsFixed(2));

  Future<bool> submit() async {
    errorMsg.value = '';
    final qty = parsedQty;

    if (qty <= 0) {
      errorMsg.value = 'Quantity must be greater than 0';
      return false;
    }

    if (!isMarket.value && execPrice <= 0) {
      errorMsg.value = 'Enter a valid limit price';
      return false;
    }

    final value = double.parse((qty * execPrice).toStringAsFixed(2));

    isSubmitting.value = true;
    try {
      if (isBuy.value) {
        final balance = await _walletRepo.getBalance();
        if (value > balance) {
          errorMsg.value = 'Insufficient balance';
          return false;
        }
        await _walletRepo.setBalance(double.parse((balance - value).toStringAsFixed(2)));

        final existing = await _holdingRepo.getHolding(stock.symbol);
        if (existing == null) {
          await _holdingRepo.upsertHolding(HoldingModel(symbol: stock.symbol, quantity: qty, avgPrice: execPrice));
        } else {
          final newQty = existing.quantity + qty;
          final newAvg = double.parse(((existing.quantity * existing.avgPrice + qty * execPrice) / newQty).toStringAsFixed(2));
          await _holdingRepo.upsertHolding(HoldingModel(symbol: stock.symbol, quantity: newQty, avgPrice: newAvg));
        }
      } else {
        final existing = await _holdingRepo.getHolding(stock.symbol);
        if (existing == null || qty > existing.quantity) {
          errorMsg.value = 'Cannot sell ${qty.toStringAsFixed(qty == qty.floorToDouble() ? 0 : 2)} — only ${(existing?.quantity ?? 0).toStringAsFixed(2)} held';
          return false;
        }
        final newQty = double.parse((existing.quantity - qty).toStringAsFixed(2));
        if (newQty <= 0) {
          await _holdingRepo.deleteHolding(stock.symbol);
        } else {
          await _holdingRepo.upsertHolding(HoldingModel(symbol: stock.symbol, quantity: newQty, avgPrice: existing.avgPrice));
        }
        final balance = await _walletRepo.getBalance();
        await _walletRepo.setBalance(double.parse((balance + value).toStringAsFixed(2)));
      }

      await _orderRepo.insertOrder(OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        symbol: stock.symbol,
        side: isBuy.value ? OrderSide.buy : OrderSide.sell,
        orderType: isMarket.value ? OrderType.market : OrderType.limit,
        quantity: qty,
        price: execPrice,
        limitPrice: isMarket.value ? null : execPrice,
        createdAt: DateTime.now(),
      ));

      // Record transaction
      await _txnRepo.insertTransaction(TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: isBuy.value ? TransactionType.withdraw : TransactionType.add,
        amount: value,
        createdAt: DateTime.now(),
        description: '${isBuy.value ? "Buy" : "Sell"} ${stock.symbol} - ${qty.toStringAsFixed(qty == qty.floorToDouble() ? 0 : 2)} shares @ ₹${execPrice.toStringAsFixed(2)}',
      ));

      try {
        if (Get.isRegistered<HoldingMainController>()) Get.find<HoldingMainController>().reload();
        if (Get.isRegistered<FundsMainController>()) Get.find<FundsMainController>().reload();
      } catch (_) {}

      return true;
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    qtyCtrl.dispose();
    limitPriceCtrl.dispose();
    super.onClose();
  }
}
