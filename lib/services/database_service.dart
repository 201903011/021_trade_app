import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends GetxService {
  static DatabaseService get to => Get.find();

  Database? _db;

  Database get database {
    assert(_db != null, 'DatabaseService not initialized. Call init() first.');
    return _db!;
  }

  Future<DatabaseService> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'trading_app.db');

    _db = await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) await runMigrations(db);
        if (oldVersion < 3) await _addTransactionsTable(db);
      },
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
    debugPrint('[DatabaseService] opened at $path');
    return this;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE watchlists (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        sort_order INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE watchlist_stocks (
        watchlist_id TEXT NOT NULL,
        symbol TEXT NOT NULL,
        sort_order INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (watchlist_id, symbol),
        FOREIGN KEY (watchlist_id) REFERENCES watchlists(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE holdings (
        symbol TEXT PRIMARY KEY,
        quantity REAL NOT NULL,
        avg_price REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id TEXT PRIMARY KEY,
        symbol TEXT NOT NULL,
        side TEXT NOT NULL,
        order_type TEXT NOT NULL DEFAULT 'market',
        quantity REAL NOT NULL,
        price REAL NOT NULL,
        limit_price REAL,
        created_at INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE wallet (
        id INTEGER PRIMARY KEY DEFAULT 1,
        balance REAL NOT NULL DEFAULT 0.0
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');

    // Seed wallet with ₹10,00,000 starting balance
    await db.insert('wallet', {'id': 1, 'balance': 0.0});
  }

  /// Run migrations for existing database instances.
  Future<void> runMigrations(Database db) async {
    // Add order_type column (default 'market') if missing
    try {
      await db.execute("ALTER TABLE orders ADD COLUMN order_type TEXT NOT NULL DEFAULT 'market'");
    } catch (_) {}
    // Add limit_price column (nullable) if missing
    try {
      await db.execute('ALTER TABLE orders ADD COLUMN limit_price REAL');
    } catch (_) {}
  }

  /// Add transactions table for v2 → v3 upgrade.
  Future<void> _addTransactionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS transactions (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');
  }

  @override
  void onClose() {
    _db?.close();
    super.onClose();
  }
}
