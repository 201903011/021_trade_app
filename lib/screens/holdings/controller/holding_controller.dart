import 'package:get/get.dart';
import 'package:minimals/injection.dart';
import 'package:minimals/models/holding_model.dart';
import 'package:minimals/screens/holdings/repository/holding_repository.dart';
import 'package:minimals/screens/holdings/repository/wallet_repository.dart';

/// displayMode: 0 = Current/Invested, 1 = Returns %, 2 = Day Change %
class HoldingMainController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<HoldingModel> holdings = <HoldingModel>[].obs;
  final RxDouble walletBalance = 0.0.obs;
  final RxString sortField = 'currentValue'.obs;
  final RxBool sortAscending = false.obs;
  final RxInt displayMode = 0.obs;

  final HoldingRepository _holdingRepo = getIt<HoldingRepository>();
  final WalletRepository _walletRepo = getIt<WalletRepository>();

  @override
  void onInit() {
    super.onInit();
    reload();
  }

  Future<void> reload() async {
    isLoading.value = true;
    try {
      final h = await _holdingRepo.getAllHoldings();
      final bal = await _walletRepo.getBalance();
      holdings.assignAll(h);
      walletBalance.value = bal;
    } finally {
      isLoading.value = false;
    }
  }

  void setSortField(String field) => sortField.value = field;

  void toggleSortDirection() => sortAscending.value = !sortAscending.value;

  void toggleDisplayMode() => displayMode.value = (displayMode.value + 1) % 3;

  String get displayModeLabel {
    switch (displayMode.value) {
      case 1:
        return 'Returns (%)';
      case 2:
        return 'Day Change %';
      default:
        return 'Current (Invested)';
    }
  }

  List<HoldingModel> sortedHoldings() {
    final list = List<HoldingModel>.from(holdings);
    final asc = sortAscending.value;
    switch (sortField.value) {
      case 'stockName':
        list.sort((a, b) => asc ? a.symbol.compareTo(b.symbol) : b.symbol.compareTo(a.symbol));
        break;
      case 'returns':
        list.sort((a, b) => asc ? a.pnlPercent.compareTo(b.pnlPercent) : b.pnlPercent.compareTo(a.pnlPercent));
        break;
      case 'dayChange':
        list.sort((a, b) => asc ? a.dayChangePercent.compareTo(b.dayChangePercent) : b.dayChangePercent.compareTo(a.dayChangePercent));
        break;
      case 'currentValue':
      default:
        list.sort((a, b) => asc ? a.currentValue.compareTo(b.currentValue) : b.currentValue.compareTo(a.currentValue));
        break;
    }
    return list;
  }

  Future<void> reloadBalance() async {
    walletBalance.value = await _walletRepo.getBalance();
  }
}
