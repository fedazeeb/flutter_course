import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course/componet/constants.dart';
import 'package:course/models/cart.dart';
import 'package:course/sitting/navigationdrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

//   @override
//   _CategoryState createState() => _CategoryState();
// }
//
// class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Category"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).pushNamed("search");
              },
            ),
          ],
        ),
        drawer: MyDrawer(
          pagenumber: 1,
        ),
        body: FutureBuilder<QuerySnapshot>(
            // <2> Pass `Future<QuerySnapshot>` to future
            future: FirebaseFirestore.instance.collection('Categories').get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                final provider = Provider.of<Cart>(context);
                return GridView(
                  //itemCount: documents.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 2 : 3),
                  children: documents
                      .map(
                        (doc) => Card(
                          child: Center(
                            child: ListTile(
                              title: Container(
                                padding: EdgeInsets.all(kDefaultPaddin),
                                // For  demo we use fixed height  and width
                                // Now we dont need them
                                // height: 180,
                                // width: 160,
                                decoration: BoxDecoration(
                                  color: Color(0xFF3D82AE),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Image.network(
                                  doc['ImageURL'],
                                  fit: BoxFit.cover,
                                  //height: 100,
                                ),
                              ),
                              onTap: () {
                                //print(doc['ImageURL']);
                                provider.changecategory(doc['category']);
                                Navigator.of(context).pushNamed("product");
                              },
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return const Text("It's Error!");
              }
              return Text("Loading");
            })
        // GridView.builder(
        //   itemCount: 5,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
        //   itemBuilder: (BuildContext context, int index) {
        //     return Card(
        //       child: GridTile(
        //         footer: Text('name'),
        //         child:  Text('image'), //just for testing, will fill with image later
        //       ),
        //     );
        //   },
        // ),
        );
  }
}
