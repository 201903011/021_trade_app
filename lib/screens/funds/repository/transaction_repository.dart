import 'package:injectable/injectable.dart';
import 'package:minimals/models/transaction_model.dart';
import 'package:minimals/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

@Singleton()
class TransactionRepository {
  TransactionRepository();

  final _db = DatabaseService.to.database;

  Future<void> insertTransaction(TransactionModel transaction) async {
    await _db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TransactionModel>> getTransactions({
    DateTime? from,
    DateTime? to,
  }) async {
    String? where;
    List<Object?>? whereArgs;

    if (from != null && to != null) {
      where = 'created_at >= ? AND created_at <= ?';
      whereArgs = [from.millisecondsSinceEpoch, to.millisecondsSinceEpoch];
    } else if (from != null) {
      where = 'created_at >= ?';
      whereArgs = [from.millisecondsSinceEpoch];
    } else if (to != null) {
      where = 'created_at <= ?';
      whereArgs = [to.millisecondsSinceEpoch];
    }

    final rows = await _db.query(
      'transactions',
      where: where,
      whereArgs: whereArgs,
      orderBy: 'created_at DESC',
    );
    return rows.map(TransactionModel.fromMap).toList();
  }
}
