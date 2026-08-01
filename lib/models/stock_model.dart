import 'package:get/get.dart';
import 'package:minimals/constants/assets_path.dart';

/// Live price model for a single stock.
/// [lastPrice], [change], [changePercent] are [RxDouble] so any
/// [Obx] widget watching them rebuilds automatically when ticked by
/// [MarketFeedService]. No timer lives here.
class StockModel {
  final String symbol;
  final String name;
  final double basePrice;
  final String imageUrl;

  final RxDouble lastPrice;
  final RxDouble change;
  final RxDouble changePercent;

  StockModel({
    required this.symbol,
    required this.name,
    required this.basePrice,
    required this.imageUrl,
  })  : lastPrice = RxDouble(basePrice),
        change = RxDouble(0.0),
        changePercent = RxDouble(0.0);

  static final List<StockModel> allStocks = [
    StockModel(symbol: 'RELIANCE', name: 'Reliance Industries', basePrice: 2800.00, imageUrl: AppAssets.relianceIcon),
    StockModel(symbol: 'TCS', name: 'Tata Consultancy Services', basePrice: 3900.00, imageUrl: AppAssets.tcsIcon),
    StockModel(symbol: 'INFY', name: 'Infosys Limited', basePrice: 1750.00, imageUrl: AppAssets.infosysIcon),
    StockModel(symbol: 'HDFCBANK', name: 'HDFC Bank', basePrice: 1650.00, imageUrl: AppAssets.hdfcBankIcon),
    StockModel(symbol: 'ICICIBANK', name: 'ICICI Bank', basePrice: 1050.00, imageUrl: AppAssets.iciciBankIcon),
    StockModel(symbol: 'SBIN', name: 'State Bank of India', basePrice: 780.00, imageUrl: AppAssets.sbiBankIcon),
    StockModel(symbol: 'ITC', name: 'ITC Limited', basePrice: 460.00, imageUrl: AppAssets.itcIcon),
    StockModel(symbol: 'LT', name: 'Larsen & Toubro', basePrice: 3500.00, imageUrl: AppAssets.landtIcon),
    StockModel(symbol: 'BHARTIARTL', name: 'Bharti Airtel', basePrice: 1380.00, imageUrl: AppAssets.bhartiAirtelIcon),
    StockModel(symbol: 'AXISBANK', name: 'Axis Bank', basePrice: 1100.00, imageUrl: AppAssets.axisBankIcon),
  ];

  static final Map<String, StockModel> stockMap = {
    for (final s in allStocks) s.symbol: s,
  };
}
