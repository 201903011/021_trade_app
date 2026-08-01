import 'package:injectable/injectable.dart';
import 'package:minimals/models/order_model.dart';
import 'package:minimals/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

@Singleton()
class OrderRepository {
  OrderRepository();

  final _db = DatabaseService.to.database;

  Future<void> insertOrder(OrderModel order) async {
    await _db.insert(
      'orders',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<OrderModel>> getAllOrders() async {
    final rows = await _db.query('orders', orderBy: 'created_at DESC');
    return rows.map(OrderModel.fromMap).toList();
  }
}
