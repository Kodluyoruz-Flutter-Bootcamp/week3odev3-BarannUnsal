import 'package:flutter/foundation.dart';

class Product {
  int? id;
  String? name;
  String? price;
  Category? category;

  Product(this.name, this.price);

  Product.withId(this.id, this.name, this.price);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map["id"] = id;
    map["name"] = name;
    map["price"] = price;
    map["category"] = category;

    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    price = map["price"];
    category = map["category"];
  }
}
