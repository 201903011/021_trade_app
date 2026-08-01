import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';

class DashboardMainController extends GetxController {
  final RxBool isLoading = false.obs;

  /// All 10 stocks - the market feed service already ticks their prices.
  List<StockModel> get stocks => StockModel.allStocks;
}
