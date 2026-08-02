import 'package:get/get.dart';
import 'package:minimals/injection.dart';
import 'package:minimals/models/order_model.dart';
import 'package:minimals/screens/holdings/repository/order_repository.dart';

class OrdersMainController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<OrderModel> orders = <OrderModel>[].obs;

  final Rx<DateTime?> filterFrom = Rx<DateTime?>(null);
  final Rx<DateTime?> filterTo = Rx<DateTime?>(null);

  final OrderRepository _orderRepo = getIt<OrderRepository>();

  String? get activeFilterLabel {
    if (filterFrom.value == null && filterTo.value == null) return null;

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1));

    if (filterFrom.value == todayStart && filterTo.value == todayEnd) return 'Today';

    final monday = todayStart.subtract(Duration(days: todayStart.weekday - 1));
    final weekEnd = monday.add(const Duration(days: 7)).subtract(const Duration(milliseconds: 1));
    if (filterFrom.value == monday && filterTo.value == weekEnd) return 'This Week';

    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59, 999);
    if (filterFrom.value == monthStart && filterTo.value == monthEnd) return 'This Month';

    final threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);
    if (filterFrom.value == threeMonthsAgo && filterTo.value == now) return 'Last 3 Months';

    return 'Custom';
  }

  @override
  void onInit() {
    super.onInit();
    reload();
  }

  Future<void> reload() async {
    isLoading.value = true;
    try {
      final o = await _orderRepo.getOrders(from: filterFrom.value, to: filterTo.value);
      orders.assignAll(o);
    } finally {
      isLoading.value = false;
    }
  }

  void setDateFilter(DateTime? from, DateTime? to) {
    filterFrom.value = from;
    filterTo.value = to;
    reload();
  }

  void clearFilter() {
    filterFrom.value = null;
    filterTo.value = null;
    reload();
  }
}
