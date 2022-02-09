import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course/componet/constants.dart';
import 'package:course/componet/widgets.dart';
import 'package:course/models/cart.dart';
import 'package:course/models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkout.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<Item> items = [
    Item(name: "S20", price: 200),
    Item(price: 300, name: "realme"),
  ];

  Future<QuerySnapshot> getProdcut() async {
    CollectionReference _prodcut =
        FirebaseFirestore.instance.collection('product');

    return await _prodcut.get();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final String documentId = "Q44JhxNzzAijqveKxK4I";
    final provider = Provider.of<Cart>(context);
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Checkout();
              }));
            },
            icon: const Icon(Icons.add_shopping_cart),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: Consumer<Cart>(
              builder: (context, cart, child) {
                return Text("Count of Product ${cart.count}");
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
          // <2> Pass `Future<QuerySnapshot>` to future
          future: FirebaseFirestore.instance
              .collection('product')
              .where("category", isEqualTo: provider.getcategory)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // <3> Retrieve `List<DocumentSnapshot>` from snapshot
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                      child: Text(
                        provider.getcategory,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 2 : 3),
                        children: documents
                            .map(
                              (doc) => Card(
                                child: itembuild(
                                  context,
                                  doc['imageurl'],
                                  doc['name'],
                                  doc['price'].toDouble(),
                                  doc['description_en'],
                                  doc['size'],
                                  doc['link'],
                                ),
                              ),
                            )
                            .toList()),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Text("It's Error!");
            }
            return Text("Loading");
          }),
    );
  }
}
