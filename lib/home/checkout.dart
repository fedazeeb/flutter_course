import 'package:course/componet/alertdialogs.dart';
import 'package:course/models/cart.dart';
import 'package:course/models/request.dart';
import 'package:course/sitting/navigationdrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check OUT"),
        actions: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text("Total Price   "),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Consumer<Cart>(
              builder: (context, cart, child) {
                return Text("${cart.totalprice}");
              },
            ),
          ),
        ],
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    itemCount: cart.count,
                    itemBuilder: (context, index) {
                      String? imageUrl = cart.getbasket[index].image;
                      double priceofone = cart.getbasket[index].count *
                          cart.getbasket[index].price!;
                      return Container(
                        height: 150,
                        child: Card(
                          //  margin: EdgeInsets.all(20),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CircleAvatar(
                                    radius: 90,
                                    backgroundColor: Colors.black38,
                                    child: Image.network(
                                      imageUrl!,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${cart.getbasket[index].name}",
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "count of items ${cart.getbasket[index].count}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Text(
                                          "price of items ${priceofone.toString()}\$",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      // showAlert(context);
                                      showAlertDialog(context,cart.getbasket[index]);
                                    },
                                    icon: Icon(Icons.delete),
                                    iconSize: 30.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // child: ListTile(
                          //   leading: CircleAvatar(
                          //     radius: 45,
                          //     child: ClipRRect(
                          //         borderRadius: BorderRadius.circular(45),
                          //         child: Image.network(imageUrl!)),
                          //   ),
                          //   title: Text("${cart.getbasket[index].name}"),
                          //   //////////////////////////////////////////////////////
                          //   subtitle: Text(
                          //       "count of items ${cart.getbasket[index].count}"),
                          //   //////////////////////////////////////////////////////
                          //   trailing: Consumer<Cart>(
                          //     builder: (context, cart, child) {
                          //       return IconButton(
                          //         icon: const Icon(Icons.remove),
                          //         onPressed: () {
                          //           //  cart.delte(index);
                          //           // Navigator.of(context).push(route)
                          //         },
                          //       );
                          //     },
                          //   ),
                          // ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
               height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (cart.allitem.isNotEmpty) {
                    Request req = Request(
                        requestdate: DateTime.now(),
                        userid: "1111",
                        totalprice: cart.totalprice,
                        items: cart.allitem);
                    await req.add_request();
                  }
                },
                child: const Text(
                  "Add Request",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  primary: Colors.black,
                 minimumSize: Size(0, 40),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }
}
