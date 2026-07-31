import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:minimals/models/stock_model.dart';
import 'package:minimals/models/watchlist_model.dart';

class WatchListMainController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<WatchlistModel> watchlists = <WatchlistModel>[].obs;
  final RxInt selectedIndex = 0.obs;

  Timer? _priceTimer;
  final _random = Random();

  // ---------- lifecycle ----------

  @override
  void onInit() {
    super.onInit();
    _seedDefaultWatchlist();
    _startPriceSimulation();
  }

  @override
  void onClose() {
    _priceTimer?.cancel();
    super.onClose();
  }

  // ---------- helpers ----------

  WatchlistModel? get currentWatchlist => watchlists.isEmpty ? null : watchlists[selectedIndex.value];

  List<StockModel> stocksForWatchlist(WatchlistModel wl) => wl.symbols.map((s) => StockModel.stockMap[s]).whereType<StockModel>().toList();

  bool isStockInWatchlist(String watchlistId, String symbol) {
    final wl = watchlists.firstWhereOrNull((w) => w.id == watchlistId);
    return wl?.symbols.contains(symbol) ?? false;
  }

  // ---------- watchlist CRUD ----------

  void createWatchlist(String name) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    watchlists.add(WatchlistModel(id: id, name: name));
    selectedIndex.value = watchlists.length - 1;
  }

  void renameWatchlist(String id, String newName) {
    final idx = watchlists.indexWhere((w) => w.id == id);
    if (idx == -1) return;
    watchlists[idx].name = newName;
    watchlists.refresh();
  }

  void deleteWatchlist(String id) {
    final idx = watchlists.indexWhere((w) => w.id == id);
    if (idx == -1) return;
    watchlists.removeAt(idx);
    if (selectedIndex.value >= watchlists.length) {
      selectedIndex.value = (watchlists.length - 1).clamp(0, double.maxFinite.toInt());
    }
  }

  void selectWatchlist(int index) => selectedIndex.value = index;

  // ---------- stock CRUD ----------

  void addStock(String watchlistId, String symbol) {
    final idx = watchlists.indexWhere((w) => w.id == watchlistId);
    if (idx == -1) return;
    if (!watchlists[idx].symbols.contains(symbol)) {
      watchlists[idx].symbols.add(symbol);
      watchlists.refresh();
    }
  }

  void removeStock(String watchlistId, String symbol) {
    final idx = watchlists.indexWhere((w) => w.id == watchlistId);
    if (idx == -1) return;
    watchlists[idx].symbols.remove(symbol);
    watchlists.refresh();
  }

  void reorderStocks(String watchlistId, int oldIndex, int newIndex) {
    final idx = watchlists.indexWhere((w) => w.id == watchlistId);
    if (idx == -1) return;
    final symbols = watchlists[idx].symbols;
    if (newIndex > oldIndex) newIndex--;
    final item = symbols.removeAt(oldIndex);
    symbols.insert(newIndex, item);
    watchlists.refresh();
  }

  // ---------- price simulation ----------

  void _seedDefaultWatchlist() {
    final wl = WatchlistModel(
      id: '1',
      name: 'My Watchlist',
      symbols: ['RELIANCE', 'TCS', 'INFY', 'HDFCBANK', 'ICICIBANK'],
    );
    watchlists.add(wl);
  }

  void _startPriceSimulation() {
    _priceTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      for (final stock in StockModel.allStocks) {
        final delta = stock.lastPrice.value * (_random.nextDouble() * 0.01 - 0.005);
        final newPrice = (stock.lastPrice.value + delta).clamp(1.0, double.infinity);
        stock.lastPrice.value = double.parse(newPrice.toStringAsFixed(2));
        stock.change.value = double.parse((newPrice - stock.basePrice).toStringAsFixed(2));
        stock.changePercent.value = double.parse(((newPrice - stock.basePrice) / stock.basePrice * 100).toStringAsFixed(2));
      }
    });
  }
}
