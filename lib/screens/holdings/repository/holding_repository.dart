import 'package:minimals/models/holding_model.dart';
import 'package:minimals/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class HoldingRepository {
  final _db = DatabaseService.to.database;

  Future<List<HoldingModel>> getAllHoldings() async {
    final rows = await _db.query('holdings');
    return rows.map(HoldingModel.fromMap).toList();
  }

  /// Insert or update holding, recalculating weighted average cost on buy.
  Future<void> upsertHolding(HoldingModel holding) async {
    await _db.insert(
      'holdings',
      holding.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<HoldingModel?> getHolding(String symbol) async {
    final rows = await _db.query(
      'holdings',
      where: 'symbol = ?',
      whereArgs: [symbol],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return HoldingModel.fromMap(rows.first);
  }

  Future<void> deleteHolding(String symbol) async {
    await _db.delete('holdings', where: 'symbol = ?', whereArgs: [symbol]);
  }
}
