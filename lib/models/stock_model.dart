import 'package:get/get.dart';

class StockModel {
  final String symbol;
  final String name;
  final double basePrice;

  final RxDouble lastPrice;
  final RxDouble change;
  final RxDouble changePercent;

  StockModel({
    required this.symbol,
    required this.name,
    required this.basePrice,
  })  : lastPrice = RxDouble(basePrice),
        change = RxDouble(0.0),
        changePercent = RxDouble(0.0);

  static final List<StockModel> allStocks = [
    StockModel(symbol: 'RELIANCE', name: 'Reliance Industries', basePrice: 2800.00),
    StockModel(symbol: 'TCS', name: 'Tata Consultancy Services', basePrice: 3900.00),
    StockModel(symbol: 'INFY', name: 'Infosys Limited', basePrice: 1750.00),
    StockModel(symbol: 'HDFCBANK', name: 'HDFC Bank', basePrice: 1650.00),
    StockModel(symbol: 'ICICIBANK', name: 'ICICI Bank', basePrice: 1050.00),
    StockModel(symbol: 'SBIN', name: 'State Bank of India', basePrice: 780.00),
    StockModel(symbol: 'ITC', name: 'ITC Limited', basePrice: 460.00),
    StockModel(symbol: 'LT', name: 'Larsen & Toubro', basePrice: 3500.00),
    StockModel(symbol: 'BHARTIARTL', name: 'Bharti Airtel', basePrice: 1380.00),
    StockModel(symbol: 'AXISBANK', name: 'Axis Bank', basePrice: 1100.00),
  ];

  static final Map<String, StockModel> stockMap = {
    for (final s in allStocks) s.symbol: s,
  };
}
