import 'package:get/get.dart';
import 'package:minimals/injection.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/models/watchlist_model.dart';
import 'package:minimals/screens/watchlist/repository/watchlist_repository.dart';

class WatchListMainController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<WatchlistModel> watchlists = <WatchlistModel>[].obs;
  final RxInt selectedIndex = 0.obs;

  final WatchlistRepository _repo = getIt<WatchlistRepository>();

  @override
  void onInit() {
    super.onInit();
    _loadWatchlists();
  }

  WatchlistModel? get currentWatchlist => watchlists.isEmpty ? null : watchlists[selectedIndex.value];

  List<StockModel> stocksForWatchlist(WatchlistModel wl) => wl.symbols.map((s) => StockModel.stockMap[s]).whereType<StockModel>().toList();

  bool isStockInWatchlist(String watchlistId, String symbol) {
    final wl = watchlists.firstWhereOrNull((w) => w.id == watchlistId);
    return wl?.symbols.contains(symbol) ?? false;
  }

  Future<void> createWatchlist(String name) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final wl = WatchlistModel(id: id, name: name, sortOrder: watchlists.length);
    await _repo.saveWatchlist(wl);
    watchlists.add(wl);
    selectedIndex.value = watchlists.length - 1;
  }

  Future<void> renameWatchlist(String id, String newName) async {
    final idx = watchlists.indexWhere((w) => w.id == id);
    if (idx == -1) return;
    await _repo.updateWatchlistName(id, newName);
    watchlists[idx].name = newName;
    watchlists.refresh();
  }

  Future<void> deleteWatchlist(String id) async {
    final idx = watchlists.indexWhere((w) => w.id == id);
    if (idx == -1) return;
    await _repo.deleteWatchlist(id);
    watchlists.removeAt(idx);
    if (selectedIndex.value >= watchlists.length) {
      selectedIndex.value = (watchlists.length - 1).clamp(0, double.maxFinite.toInt());
    }
  }

  void selectWatchlist(int index) => selectedIndex.value = index;

  Future<void> addStock(String watchlistId, String symbol) async {
    final idx = watchlists.indexWhere((w) => w.id == watchlistId);
    if (idx == -1) return;
    if (watchlists[idx].symbols.contains(symbol)) return;
    watchlists[idx].symbols.add(symbol);
    await _repo.saveStocksForWatchlist(watchlistId, watchlists[idx].symbols);
    watchlists.refresh();
  }

  Future<void> removeStock(String watchlistId, String symbol) async {
    final idx = watchlists.indexWhere((w) => w.id == watchlistId);
    if (idx == -1) return;
    watchlists[idx].symbols.remove(symbol);
    await _repo.saveStocksForWatchlist(watchlistId, watchlists[idx].symbols);
    watchlists.refresh();
  }

  Future<void> reorderStocks(String watchlistId, int oldIndex, int newIndex) async {
    final idx = watchlists.indexWhere((w) => w.id == watchlistId);
    if (idx == -1) return;
    final symbols = watchlists[idx].symbols;
    if (newIndex > oldIndex) newIndex--;
    final item = symbols.removeAt(oldIndex);
    symbols.insert(newIndex, item);
    await _repo.saveStocksForWatchlist(watchlistId, symbols);
    watchlists.refresh();
  }

  Future<void> _loadWatchlists() async {
    isLoading.value = true;
    try {
      final loaded = await _repo.getAllWatchlists();
      if (loaded.isEmpty) {
        await createWatchlist('My Watchlist');
        await addStock(watchlists.first.id, 'RELIANCE');
        await addStock(watchlists.first.id, 'TCS');
        await addStock(watchlists.first.id, 'INFY');
      } else {
        watchlists.assignAll(loaded);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
