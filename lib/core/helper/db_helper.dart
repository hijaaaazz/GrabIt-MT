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

  static Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'grabit_app_.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE banners(
            id TEXT PRIMARY KEY,
            title TEXT,
            image_url TEXT,
            section_id TEXT,
            section_order INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE products(
            id TEXT PRIMARY KEY,
            sku TEXT,
            product_name TEXT,
            product_image TEXT,
            product_rating INTEGER,
            actual_price TEXT,
            offer_price TEXT,
            discount TEXT,
            section_id TEXT,
            section_title TEXT,
            section_order INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE categories(
            id TEXT PRIMARY KEY,
            name TEXT,
            image_url TEXT,
            section_id TEXT,
            section_title TEXT,
            section_order INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE single_banner(
            id TEXT PRIMARY KEY,
            title TEXT,
            image_url TEXT,
            section_id TEXT,
            section_order INTEGER
          )
        ''');
        log('Tables created successfully');
      },
    );
  }
}
