import 'package:minimals/models/stock_model.dart';

class HoldingModel {
  final String symbol;
  double quantity;
  double avgPrice;

  HoldingModel({
    required this.symbol,
    required this.quantity,
    required this.avgPrice,
  });

  // --- runtime computed getters (use live price from MarketFeedService) ---

  double get currentPrice => StockModel.stockMap[symbol]?.lastPrice.value ?? avgPrice;

  double get currentValue => double.parse((quantity * currentPrice).toStringAsFixed(2));

  double get investedValue => double.parse((quantity * avgPrice).toStringAsFixed(2));

  double get pnl => double.parse((currentValue - investedValue).toStringAsFixed(2));

  double get pnlPercent => investedValue == 0 ? 0.0 : double.parse(((pnl / investedValue) * 100).toStringAsFixed(2));

  double get dayChange => double.parse((quantity * (StockModel.stockMap[symbol]?.change.value ?? 0.0)).toStringAsFixed(2));

  double get dayChangePercent => double.parse((StockModel.stockMap[symbol]?.changePercent.value ?? 0.0).toStringAsFixed(2));

  // --- SQLite serialization ---

  Map<String, dynamic> toMap() => {
        'symbol': symbol,
        'quantity': quantity,
        'avg_price': avgPrice,
      };

  factory HoldingModel.fromMap(Map<String, dynamic> map) => HoldingModel(
        symbol: map['symbol'] as String,
        quantity: (map['quantity'] as num).toDouble(),
        avgPrice: (map['avg_price'] as num).toDouble(),
      );
}
