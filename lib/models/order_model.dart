enum OrderSide { buy, sell }

enum OrderType { market, limit }

class OrderModel {
  final String id;
  final String symbol;
  final OrderSide side;
  final OrderType orderType;
  final double quantity;
  final double price;
  final double? limitPrice;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.symbol,
    required this.side,
    this.orderType = OrderType.market,
    required this.quantity,
    required this.price,
    this.limitPrice,
    required this.createdAt,
  });

  double get orderValue => double.parse((quantity * price).toStringAsFixed(2));

  Map<String, dynamic> toMap() => {
        'id': id,
        'symbol': symbol,
        'side': side.name,
        'order_type': orderType.name,
        'quantity': quantity,
        'price': price,
        'limit_price': limitPrice,
        'created_at': createdAt.millisecondsSinceEpoch,
      };

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
        id: map['id'] as String,
        symbol: map['symbol'] as String,
        side: map['side'] == 'buy' ? OrderSide.buy : OrderSide.sell,
        orderType: map['order_type'] == 'limit' ? OrderType.limit : OrderType.market,
        quantity: (map['quantity'] as num).toDouble(),
        price: (map['price'] as num).toDouble(),
        limitPrice: map['limit_price'] != null ? (map['limit_price'] as num).toDouble() : null,
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      );
}
