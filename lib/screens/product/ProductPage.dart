import 'package:flutter/material.dart';
import 'package:homework3/models/product.dart';
import 'package:homework3/screens/product/ProductDetailPage.dart';

import '../../utils/dbHelper.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> lstProduct = <Product>[];
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtCategory = TextEditingController();

  DataBaseHelper dbhelper = DataBaseHelper();

  int selectedId = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      getPeople();
    });
  }

  getPeople() async {
    var result = await dbhelper.getAllProduct();
    setState(() {
      lstProduct = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürünler"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: txtName,
              decoration: const InputDecoration(
                  label: Text('Ürün Ad'), border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: txtPrice,
              decoration: const InputDecoration(
                  label: Text('Fiyat'), border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: txtCategory,
              decoration: const InputDecoration(
                  label: Text('Kategori'), border: OutlineInputBorder()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: saveProduct,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text('Kaydet'),
              ),
              ElevatedButton(
                onPressed: updatePerson,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
                child: const Text('Güncelle'),
              )
            ],
          ),
          lstProduct.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      itemCount: lstProduct.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                        product: lstProduct[index])),
                              );
                              // setState(() {
                              //   txtTitle.text =
                              //       lstPerson[index].title.toString();
                              //   txtName.text =
                              //       lstPerson[index].name.toString();
                              //   selectedId = lstPerson[index].id!;
                              //   txtLastName.text = lstPerson[index].lastname!;
                              // });
                            },
                            title: Text(lstProduct[index].name!),
                            subtitle: Text(
                                "${lstProduct[index].name} ${lstProduct[index].price!}"),
                            trailing:
                                // IconButton(icon: Icon(Icons.delete),
                                //  onPressed: (){

                                //  },
                                // )
                                GestureDetector(
                              onTap: () {
                                deletePerson(lstProduct[index].id!);
                              },
                              child: const Icon(Icons.delete),
                            ),
                          ),
                        );
                      }),
                )
              : const Card(),
        ],
      ),
    );
  }

  saveProduct() {
    Product product =
        Product(txtName.text.toString(), txtPrice.text.toString());
    save(product);
  }

  Future<void> save(Product product) async {
    dbhelper.insert(product);
    setState(() {
      getPeople();
    });
  }

  updatePerson() {
    Product product = Product.withId(
        selectedId, txtName.text.toString(), txtPrice.text.toString());

    update(product);
  }

  Future<void> update(Product product) async {
    dbhelper.update(product);
    setState(() {
      getPeople();
    });
  }

  deletePerson(int id) async {
    dbhelper;
    setState(() {
      getPeople();
    });
  }
}
