import 'package:injectable/injectable.dart';
import 'package:minimals/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

@Singleton()
class WalletRepository {
  WalletRepository();

  final _db = DatabaseService.to.database;

  /// Returns current balance. Seeds ₹10,00,000 if row missing.
  Future<double> getBalance() async {
    final rows = await _db.query('wallet', where: 'id = ?', whereArgs: [1]);
    if (rows.isEmpty) {
      await _db.insert('wallet', {'id': 1, 'balance': 1000000.0}, conflictAlgorithm: ConflictAlgorithm.ignore);
      return 1000000.0;
    }
    return (rows.first['balance'] as num).toDouble();
  }

  Future<void> setBalance(double balance) async {
    await _db.update(
      'wallet',
      {'balance': balance},
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}
