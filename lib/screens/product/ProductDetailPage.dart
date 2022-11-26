// ignore: file_names
import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key, required this.product});

  Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Ürün"), backgroundColor: Colors.blueGrey),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 15)),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(product.id.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(product.name.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(product.price.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(product.category.toString()),
                ),
              ],
            ),
          ),
        ));
  }
}
