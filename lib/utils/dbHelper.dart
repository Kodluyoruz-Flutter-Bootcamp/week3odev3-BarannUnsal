// ignore_for_file: file_names

import 'package:homework3/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static Database? _database;

  String productsTable = "products";
  String clmnId = "id";
  String clmnName = "name";
  String clmnPrice = "price";
  String clmnCategory = "category";

  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database?> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "products.db");
    var productsDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return productsDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table $productsTable ($clmnId integer primary key,$clmnId integer ,$clmnName text ,$clmnPrice text, $clmnCategory text) ");
  }

  Future<int> insert(Product product) async {
    Database? db = await database;

    var result = await db!.insert(productsTable, product.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database? db = await database;

    var result = await db!.rawDelete("delete from $productsTable where id=$id");

    return result;
  }

  Future<int> update(Product product) async {
    Database? db = await database;

    var result = await db!.update(productsTable, product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }

  Future<List<Product>> getAllProduct() async {
    Database? db = await database;

    var result = await db!.query(productsTable);

    List<Product> lstproduct = <Product>[];
    for (var item in result) {
      lstproduct.add(Product.fromMap(item));
    }

    return lstproduct;
  }
}
