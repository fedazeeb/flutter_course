import 'package:course/componet/add_to_cart.dart';
import 'package:course/componet/color_and_size.dart';
import 'package:course/componet/constants.dart';
import 'package:course/componet/counter_with_fav_btn.dart';
import 'package:course/componet/discription.dart';
import 'package:course/componet/productitemwithimage.dart';
import 'package:course/models/cart.dart';
import 'package:course/models/item.dart';
import 'package:course/sitting/webview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:shop_app/constants.dart';
// import 'package:shop_app/models/Product.dart';
//
// import 'add_to_cart.dart';
// import 'color_and_size.dart';
// import 'counter_with_fav_btn.dart';
// import 'description.dart';
// import 'product_title_with_image.dart';

class Productbody extends StatelessWidget {
  // final Product product;
  final Item? item;

  const Productbody({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<Cart>(context);
    int numOfItems = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.22),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        ColorAndSize(
                          size: item!.size,
                        ),
                        //SizedBox(height: kDefaultPaddin / 2),
                        Expanded(
                            child: Description(
                          dummyText: item!.description_en,
                        )),
                        //SizedBox(height: kDefaultPaddin / 2),
                        // SizedBox(height: kDefaultPaddin / 2),
                        // AddToCart(),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: kDefaultPaddin),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    primary: Colors.black38,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      WebViewExample.routeName,
                                      arguments: item!.link,
                                    );
                                  },
                                  child: const Text("Show More"),
                                ),
                                //CounterWithFavBtn(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 40,
                                          height: 32,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              side: const BorderSide(
                                                  width: 2,
                                                  color: Colors.green),
                                            ),
                                            onPressed: () {
                                              provider.delte(item!);
                                            },
                                            child: Icon(Icons.remove),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: kDefaultPaddin / 2),
                                          child: Text(
                                            // if our item is less  then 10 then  it shows 01 02 like that
                                            // numOfItems.toString().padLeft(2, "0"),
                                            provider
                                                .countOfOneItem(item!)
                                                .toString(),
                                            // cart.getbasket[index].count,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                          height: 32,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              side: BorderSide(
                                                  width: 2,
                                                  color: Colors.green),
                                            ),
                                            onPressed: () {
                                              provider.add(item!);
                                            },
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 37,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          side: BorderSide(
                                              width: 2, color: Colors.green),
                                        ),
                                        onPressed: /*press*/ () {
                                          Navigator.of(context)
                                              .pushNamed('myrequest');
                                        },
                                        child:
                                            const Icon(Icons.add_shopping_cart),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: kDefaultPaddin * 2,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18)),
                                          color: Colors.black,
                                          onPressed: () {},
                                          child: Text(
                                            "Buy  Now".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProductTitleWithImage(
                    price: item!.price,
                    imageurl: item!.image,
                    product: item!.name.toString(),
                  ),
                  //ProductTitleWithImage(product: product)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
