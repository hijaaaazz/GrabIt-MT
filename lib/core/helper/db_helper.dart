import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<void> clearDatabase() async {
    final path = join(await getDatabasesPath(), 'grabitsections'); // Fixed name
    await deleteDatabase(path);
    _db = null;
    log('Database cleared successfully');
  }

  static Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'grabitsections'); // Fixed name
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print('Creating tables for database version $version');
        await db.execute('''
          CREATE TABLE banners(
            id TEXT PRIMARY KEY,
            title TEXT,
            image_url TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE popular_products(
            id TEXT PRIMARY KEY,
            sku TEXT,
            product_name TEXT,
            product_image TEXT,
            product_rating INTEGER,
            actual_price TEXT,
            offer_price TEXT,
            discount TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE featured_products(
            id TEXT PRIMARY KEY,
            sku TEXT,
            product_name TEXT,
            product_image TEXT,
            product_rating INTEGER,
            actual_price TEXT,
            offer_price TEXT,
            discount TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE categories(
            id TEXT PRIMARY KEY,
            title TEXT,
            image_url TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE single_banner(
            id TEXT PRIMARY KEY,
            title TEXT,
            image_url TEXT
          )
        ''');
        log('Tables created successfully');
      },
    );
  }
}