import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tr_store/modules/products/model/products_response.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) {
      return _database!;
    }

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'product.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Product('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'content TEXT,'
          'title TEXT,'
          'thumbnail TEXT,'
          'image TEXT,'
          'item INTEGER,'
          'price INTEGER'
          ')');
    });
  }

  // Insert employee on database
  createProduct(Products products) async {
    await deleteAllProducts();
    final db = await database;
    final res = await db.insert('Product', products.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllProducts() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Product');

    return res;
  }

  Future<List<Products>> getAllProducts() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Product");

    List<Products> list =
        res.isNotEmpty ? res.map((c) => Products.fromJson(c)).toList() : [];

    return list;
  }
}
