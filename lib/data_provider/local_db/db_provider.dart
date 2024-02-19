import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tr_store/modules/products/model/products_response.dart';
import 'package:tr_store/utils/extension.dart';

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

  // Create the database and the Product table
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
      await db.execute('CREATE TABLE Cart('
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

  // Insert product on database
  createProduct(Products products) async {
    await deleteAllProducts();
    final db = await database;
    final res = await db.insert('Product', products.toJson());

    return res;
  }

  // Delete all product
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

  Future<void> updateProduct(Products products) async {
    try {
      products.item.toString().log();

      final Database db = await database;

      await db.update(
        'Product',
        products.toJson(),
        where: "id = ?",
        whereArgs: [products.id],
      );
    } catch (e) {
      "Error updating product: $e".log();
    }
    createCart(products);
  }

  createCart(Products products) async {
    final db = await database;
    final cart = await getAllCarts();
    final index = cart.indexWhere((element) => element.id == products.id);
    if (index == -1) {
      await db.insert('Cart', products.toJson());
    }
    updateCart(products);
  }

  Future<void> updateCart(Products products) async {
    try {
      products.item.toString().log();

      final Database db = await database;

      await db.update(
        'Cart',
        products.toJson(),
        where: "id = ?",
        whereArgs: [products.id],
      );
    } catch (e) {
      "Error updating product: $e".log();
    }
  }

  // Delete all product
  Future<int> deleteAllCart() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Cart');

    return res;
  }

  Future<List<Products>> getAllCarts() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Cart");

    List<Products> list =
        res.isNotEmpty ? res.map((c) => Products.fromJson(c)).toList() : [];

    return list;
  }
}
