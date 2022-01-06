import 'dart:async';
import 'package:almajidoud/Base/Database/Product.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DB_Helper {

// Open the database and store the reference.
  static Future<Database> open_database() async {
    final database = openDatabase(
        join(await getDatabasesPath(), 'ezhyper.db'),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE product (id TEXT PRIMARY KEY , name TEXT, picture TEXT , discount TEXT ,"
                  "price INTEGER , chossed_quantity INTEGER , main_quantity INTEGER , price_after_discount INTEGER ,"
                  "cart_status INTEGER , order_status INTEGER )");
        },

        version: 1
    );
    return database;
  }

// function that inserts products into the database
  static Future<void> insert_product(Product product) async {
    final Database db = await open_database();
    await db.insert(
      'product',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// function that get products from the database
  static Future<List<Product>> get_products() async {
    final Database db = await open_database();
    // Query the table for all The Products.
    final List<Map<String, dynamic>> maps = await db.query('product');
    // Convert the List<Map<String, dynamic> into a List<Product>.
    return List.generate(maps.length, (i) {
      return Product(
          prod_id: maps[i]['id'],
          prod_name: maps[i]['name'],
          prod_discount: maps[i]['discount'],
          prod_pricture: maps[i]['picture'],
          prod_price: maps[i]['price'],
          prod_chossed_quantity: maps[i]['chossed_quantity'],
          prod_main_quantity: maps[i]['main_quantity'],
          prod_price_after_discount: maps[i]['price_after_discount'],
          prod_cart_status: maps[i]['cart_status'],
          prod_order_status: maps[i]['order_status'],

      );
    });
  }

//update product in databas
  static Future<void> update_product(Product product) async {
    final db = await open_database();
    await db.update(
        'product',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.prod_id]
    );
  }

//delete product from databas
  static Future<void> delete_product(int id) async {
    final db = await open_database();
    await db.delete(
        'product',
        where: 'id = ?',
        whereArgs: [id]
    );
  }

// use to get favourite products
  static Future<List<Product>> get_favourite_products() async {
    final Database db = await open_database();
    // Query the table for all The Products.
    final List<Map<String, dynamic>> maps = await db.query(
        'product',
        where: 'favourite_status =?',
        whereArgs: [1]
    );
    // Convert the List<Map<String, dynamic> into a List<Product>.
    return List.generate(maps.length, (i) {
      return Product(
          prod_id: maps[i]['id'],
          prod_name: maps[i]['name'],
          prod_discount: maps[i]['discount'],
          prod_pricture: maps[i]['picture'],
          prod_price: maps[i]['price'],
          prod_chossed_quantity: maps[i]['chossed_quantity'],
          prod_main_quantity: maps[i]['main_quantity'],
          prod_price_after_discount: maps[i]['price_after_discount'],
          prod_cart_status: maps[i]['cart_status'],
          prod_order_status: maps[i]['order_status']
      );
    });
  }

//use to get products which actualy in shopping cart
  static Future<List<Product>> get_cart_products() async {
    final Database db = await open_database();
    // Query the table for all The Products.
    final List<Map<String, dynamic>> maps = await db.query(
        'product',
        where: 'cart_status =?',
        whereArgs: [1]
    );
    // Convert the List<Map<String, dynamic> into a List<Product>.
    return List.generate(maps.length, (i) {
      return Product(
          prod_id: maps[i]['id'],
          prod_name: maps[i]['name'],
          prod_discount: maps[i]['discount'],
          prod_pricture: maps[i]['picture'],
          prod_price: maps[i]['price'],
          prod_chossed_quantity: maps[i]['chossed_quantity'],
          prod_main_quantity: maps[i]['main_quantity'],
          prod_price_after_discount: maps[i]['price_after_discount'],
          prod_cart_status: maps[i]['cart_status'],
          prod_order_status: maps[i]['order_status']

      );
    });
  }

// use to update cart_status to remove product from shopping cart
  static Future<void> update_cart_status(String id, int status) async {
    final db = await open_database();
    await db.rawUpdate(
        'UPDATE product SET cart_status = ? WHERE id = ?',
        [status, id]
    );
  }

// use to update favourite_status to move product to Wishlist
  static Future<void> update_favourite_status(String id, int status) async {
    final db = await open_database();
    await db.rawUpdate(
        'UPDATE product SET favourite_status = ? WHERE id = ?',
        [status, id]
    );
  }

//use to get price of all products in cart
  static Future getTotal_Amount() async {
    final db = await open_database();
    return await db.rawQuery(
        'SELECT SUM(price_after_discount * chossed_quantity) as total FROM product WHERE cart_status = ?',
        [1]
    );
  }

//use to calculate price of all products in cart
  static void calculate_amount() async {
    var total = (await DB_Helper.getTotal_Amount())[0]['total'];
    StaticData.TOTAL_AMOUNT = (total==null)?0:total;
  }

  //use to get number of all products in cart
  static Future getItems_number() async {
    final db = await open_database();
    return await db.rawQuery(
        'SELECT COUNT(*) as number FROM product WHERE cart_status = ?',
        [1]
    );
  }

  //use to calculate number of all products in cart
  static void cart_items_number() async {
    var number = (await DB_Helper.getItems_number())[0]['number'];
    StaticData.CART_ITEMS_NUMBER = number;
  }

  static Future get_cart_items_id() async {
    final db = await open_database();
    return await db.rawQuery(
        'SELECT id FROM product WHERE cart_status = ?',
        [1]
    );
  }
  //use to get all products id in cart
  static void cart_items_id() async {
    List ids = await DB_Helper.get_cart_items_id();
    StaticData.CART_IDS=ids;

  }


}
