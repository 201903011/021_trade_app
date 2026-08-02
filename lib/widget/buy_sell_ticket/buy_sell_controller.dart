import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class BuySellController extends GetxController {
  final StockModel stock;
  BuySellController({required this.stock});

  final RxBool isBuy = true.obs;
  final RxString errorMsg = ''.obs;
  final RxBool isSubmitting = false.obs;
  final TextEditingController qtyCtrl = TextEditingController(text: '1');

  final _holdingRepo = HoldingRepository();
  final _orderRepo = OrderRepository();
  final _walletRepo = WalletRepository();
  final _txnRepo = TransactionRepository();

  // ---------- computed ----------

  double get parsedQty => double.tryParse(qtyCtrl.text.trim()) ?? 0;

  double get orderValue => double.parse((parsedQty * stock.lastPrice.value).toStringAsFixed(2));

  // ---------- submit ----------

  Future<bool> submit() async {
    errorMsg.value = '';
    final qty = parsedQty;

    // Validate quantity
    if (qty <= 0) {
      errorMsg.value = 'Quantity must be greater than 0';
      return false;
    }
    if (qty != qty.floorToDouble() && qty < 0.0001) {
      errorMsg.value = 'Invalid quantity';
      return false;
    }

    final execPrice = stock.lastPrice.value;
    final value = double.parse((qty * execPrice).toStringAsFixed(2));

    isSubmitting.value = true;
    try {
      if (isBuy.value) {
        // Balance check
        final balance = await _walletRepo.getBalance();
        if (value > balance) {
          errorMsg.value = 'Insufficient balance. Need ₹${value.toStringAsFixed(2)}, have ₹${balance.toStringAsFixed(2)}';
          return false;
        }

        // Deduct balance
        await _walletRepo.setBalance(double.parse((balance - value).toStringAsFixed(2)));

        // Update holding (weighted avg)
        final existing = await _holdingRepo.getHolding(stock.symbol);
        if (existing == null) {
          await _holdingRepo.upsertHolding(HoldingModel(symbol: stock.symbol, quantity: qty, avgPrice: execPrice));
        } else {
          final newQty = existing.quantity + qty;
          final newAvg = double.parse(((existing.quantity * existing.avgPrice + qty * execPrice) / newQty).toStringAsFixed(2));
          await _holdingRepo.upsertHolding(HoldingModel(symbol: stock.symbol, quantity: newQty, avgPrice: newAvg));
        }
      } else {
        // Sell: check holdings
        final existing = await _holdingRepo.getHolding(stock.symbol);
        if (existing == null || qty > existing.quantity) {
          errorMsg.value = 'Cannot sell ${qty.toStringAsFixed(2)} — only ${(existing?.quantity ?? 0).toStringAsFixed(2)} held';
          return false;
        }

        final newQty = double.parse((existing.quantity - qty).toStringAsFixed(2));
        if (newQty <= 0) {
          await _holdingRepo.deleteHolding(stock.symbol);
        } else {
          await _holdingRepo.upsertHolding(HoldingModel(symbol: stock.symbol, quantity: newQty, avgPrice: existing.avgPrice));
        }

        // Credit balance
        final balance = await _walletRepo.getBalance();
        await _walletRepo.setBalance(double.parse((balance + value).toStringAsFixed(2)));
      }

      // Record order
      await _orderRepo.insertOrder(OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        symbol: stock.symbol,
        side: isBuy.value ? OrderSide.buy : OrderSide.sell,
        quantity: qty,
        price: execPrice,
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

      // Notify HoldingMainController to reload if registered
      try {
        if (Get.isRegistered<HoldingMainController>()) {
          Get.find<HoldingMainController>().reload();
        }
        if (Get.isRegistered<FundsMainController>()) {
          Get.find<FundsMainController>().reload();
        }
      } catch (_) {}

      return true;
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    qtyCtrl.dispose();
    super.onClose();
  }
}
