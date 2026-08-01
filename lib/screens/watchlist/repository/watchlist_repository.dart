import 'package:injectable/injectable.dart';
import 'package:minimals/models/watchlist_model.dart';
import 'package:minimals/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

@Singleton()
class WatchlistRepository {
  WatchlistRepository();

  final _db = DatabaseService.to.database;

  Future<List<WatchlistModel>> getAllWatchlists() async {
    final watchlistRows = await _db.query(
      'watchlists',
      orderBy: 'sort_order ASC',
    );

    final List<WatchlistModel> result = [];
    for (final row in watchlistRows) {
      final wl = WatchlistModel.fromMap(row);
      final stockRows = await _db.query(
        'watchlist_stocks',
        where: 'watchlist_id = ?',
        whereArgs: [wl.id],
        orderBy: 'sort_order ASC',
      );
      wl.symbols = stockRows.map((r) => r['symbol'] as String).toList();
      result.add(wl);
    }
    return result;
  }

  Future<void> saveWatchlist(WatchlistModel wl) async {
    await _db.insert(
      'watchlists',
      wl.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateWatchlistName(String id, String name) async {
    await _db.update(
      'watchlists',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteWatchlist(String id) async {
    await _db.delete('watchlists', where: 'id = ?', whereArgs: [id]);
    await _db.delete('watchlist_stocks', where: 'watchlist_id = ?', whereArgs: [id]);
  }

  Future<void> saveStocksForWatchlist(String watchlistId, List<String> symbols) async {
    final batch = _db.batch();
    batch.delete('watchlist_stocks', where: 'watchlist_id = ?', whereArgs: [watchlistId]);
    for (int i = 0; i < symbols.length; i++) {
      batch.insert(
        'watchlist_stocks',
        {'watchlist_id': watchlistId, 'symbol': symbols[i], 'sort_order': i},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }
}
