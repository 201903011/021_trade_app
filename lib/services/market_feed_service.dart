import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';

/// Tick interval in milliseconds. Lower = faster updates.
const int kTickIntervalMs = 2000;

/// Single source of truth for all live price data in the app.
/// All screens read prices directly from [StockModel.stockMap][symbol].lastPrice
/// which is an [RxDouble] — they simply wrap their widgets in [Obx].
class MarketFeedService extends GetxService {
  static MarketFeedService get to => Get.find();

  Timer? _timer;
  final _random = Random();

  @override
  void onInit() {
    super.onInit();
    _start();
    debugPrint('[MarketFeedService] started, interval=${kTickIntervalMs}ms');
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: kTickIntervalMs), (_) => _tick());
  }

  void _tick() {
    for (final stock in StockModel.allStocks) {
      // ±0.3% random walk, clamped to stay within ±7% of base price
      final delta = stock.lastPrice.value * (_random.nextDouble() * 0.006 - 0.003);
      final minPrice = stock.basePrice * 0.93;
      final maxPrice = stock.basePrice * 1.07;
      final newPrice = (stock.lastPrice.value + delta).clamp(minPrice, maxPrice);
      final rounded = double.parse(newPrice.toStringAsFixed(2));

      stock.lastPrice.value = rounded;
      stock.change.value = double.parse((rounded - stock.basePrice).toStringAsFixed(2));
      stock.changePercent.value = double.parse(((rounded - stock.basePrice) / stock.basePrice * 100).toStringAsFixed(2));

      _updateDepth(stock, rounded);
    }
  }

  void _updateDepth(StockModel stock, double ltp) {
    // Bids: levels below LTP at 0.05% steps with random qty 10–500
    for (int i = 0; i < 5; i++) {
      final step = ltp * 0.0005 * (i + 1);
      stock.bids[i].price.value = double.parse((ltp - step).toStringAsFixed(2));
      stock.bids[i].qty.value = 10 + _random.nextInt(491);
    }
    // Asks: levels above LTP at 0.05% steps with random qty 10–500
    for (int i = 0; i < 5; i++) {
      final step = ltp * 0.0005 * (i + 1);
      stock.asks[i].price.value = double.parse((ltp + step).toStringAsFixed(2));
      stock.asks[i].qty.value = 10 + _random.nextInt(491);
    }
  }
}
