import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConfig {
  static final DatabaseConfig _instance = DatabaseConfig._internal();
  factory DatabaseConfig() => _instance;
  DatabaseConfig._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'loja.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS favorites (
            id INTEGER PRIMARY KEY,
            title TEXT,
            price REAL,
            description TEXT,
            category TEXT,
            image TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS wallet (
            id INTEGER PRIMARY KEY,
            title TEXT,
            price REAL,
            description TEXT,
            category TEXT,
            image TEXT
          )
        ''');
        await db.execute('''
      CREATE TABLE IF NOT EXISTS history_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER, 
        title TEXT,
        image TEXT,
        price REAL,
        quantity INTEGER,
        category TEXT,
        description TEXT,
        purchaseDate TEXT 
      )
    ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (newVersion == 2) return;
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            title TEXT,
            price REAL,
            description TEXT,
            category TEXT,
            image TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE wallet (
            id INTEGER PRIMARY KEY,
            title TEXT,
            price REAL,
            description TEXT,
            category TEXT,
            image TEXT
          )
        ''');
        await db.execute('''
      CREATE TABLE history_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER, 
        title TEXT,
        image TEXT,
        price REAL,
        quantity INTEGER,
        category TEXT,
        description TEXT,
        purchaseDate TEXT 
      )
    ''');
      },
    );
  }
}
