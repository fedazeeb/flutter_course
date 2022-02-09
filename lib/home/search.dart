import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course/componet/constants.dart';
import 'package:course/componet/widgets.dart';
import 'package:course/models/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String value = "";
  TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          // padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            controller: textcontroller,
            autofocus: true,
            decoration: InputDecoration(
              fillColor: Colors.red,
              focusColor: Colors.red,
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                  onPressed: () {
                    textcontroller.clear();
                  },
                  icon: Icon(Icons.clear)),
              hintText: "Search ....",
            ),
            onChanged: (val) {
              setState(() {
                value = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: //value == ""
              /*?*/ FirebaseFirestore.instance.collection('product').snapshots()
          // : FirebaseFirestore.instance
          //     .collection('product')
          // .where("name", isEqualTo: value)
          //   .where("name", isLessThanOrEqualTo: "$value\uf7ff")
          // where(
          //     "name", isLessThanOrEqualTo:)
          //.snapshots()
          ,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                // final List<DocumentSnapshot> documents = snapshot.data!.docs
                final Iterable<QueryDocumentSnapshot<Object?>> documents =
                    snapshot.data!.docs.where((element) => element['name']
                        .toString()
                        .toLowerCase()
                        .contains(textcontroller.text.toLowerCase()));
                print(documents.isEmpty);
                return documents.isEmpty
                    ? const Center(
                        child: Text("No Result..."),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPaddin),
                              child: Text(
                                // provider.getcategory,
                                "Results : ",
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: (orientation ==
                                                Orientation.portrait)
                                            ? 2
                                            : 3),
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
            }
            return Text("Loading");
          }),
    );
  }
}
