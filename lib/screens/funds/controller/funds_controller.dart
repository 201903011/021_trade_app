import 'package:get/get.dart';
import 'package:minimals/injection.dart';
import 'package:minimals/models/transaction_model.dart';
import 'package:minimals/screens/funds/repository/transaction_repository.dart';
import 'package:minimals/screens/holdings/repository/wallet_repository.dart';

class FundsMainController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxDouble walletBalance = 0.0.obs;
  final RxList<TransactionModel> transactions = <TransactionModel>[].obs;

  final Rx<DateTime?> filterFrom = Rx<DateTime?>(null);
  final Rx<DateTime?> filterTo = Rx<DateTime?>(null);

  final WalletRepository _walletRepo = getIt<WalletRepository>();
  final TransactionRepository _txnRepo = getIt<TransactionRepository>();

  String? get activeFilterLabel {
    if (filterFrom.value == null && filterTo.value == null) return null;

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1));

    // Today
    if (filterFrom.value == todayStart && filterTo.value == todayEnd) {
      return 'Today';
    }

    // This Week (Monday to now)
    final monday = todayStart.subtract(Duration(days: todayStart.weekday - 1));
    final weekEnd = monday.add(const Duration(days: 7)).subtract(const Duration(milliseconds: 1));
    if (filterFrom.value == monday && filterTo.value == weekEnd) {
      return 'This Week';
    }

    // This Month
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59, 999);
    if (filterFrom.value == monthStart && filterTo.value == monthEnd) {
      return 'This Month';
    }

    // Last 3 Months
    final threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);
    if (filterFrom.value == threeMonthsAgo && filterTo.value == now) {
      return 'Last 3 Months';
    }

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
      walletBalance.value = await _walletRepo.getBalance();
      final t = await _txnRepo.getTransactions(from: filterFrom.value, to: filterTo.value);
      transactions.assignAll(t);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addFunds(double amount) async {
    final newBalance = double.parse((walletBalance.value + amount).toStringAsFixed(2));
    await _walletRepo.setBalance(newBalance);
    walletBalance.value = newBalance;
    await _txnRepo.insertTransaction(TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: TransactionType.add,
      amount: amount,
      createdAt: DateTime.now(),
      description: 'Added funds',
    ));
    await reload();
  }

  Future<void> withdrawFunds(double amount) async {
    final newBalance = double.parse((walletBalance.value - amount).clamp(0, double.infinity).toStringAsFixed(2));
    await _walletRepo.setBalance(newBalance);
    walletBalance.value = newBalance;
    await _txnRepo.insertTransaction(TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: TransactionType.withdraw,
      amount: amount,
      createdAt: DateTime.now(),
      description: 'Withdrew funds',
    ));
    await reload();
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
