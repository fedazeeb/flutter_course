import 'package:course/home/body.dart';
import 'package:course/models/cart.dart';
import 'package:course/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

@override
Widget itembuild(
  BuildContext context,
  String imageUrl,
  String item,
  double price,
  String description_en,
  String size,
  String link,
) {
  final provider = Provider.of<Cart>(context);
  return GestureDetector(
    onTap: () {
      /* Item _item = Item(name: item, price: price.toDouble());
      provider.add(_item);*/
      // Navigator.of(context).pushNamed("productbody");
      print("==============================================");
      Item _item = Item(
          price: price,
          name: item,
          image: imageUrl,
          description_en: description_en,
          size: size,
          link: link);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Productbody(
            item: _item,
          ),
        ),
      );
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
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
              imageUrl,
              fit: BoxFit.cover,
              //height: 100,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
          child: Text(
            // products is out demo list
            item,
            style: TextStyle(color: kTextLightColor),
          ),
        ),
        Text(
          "${price} \$",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
