import 'package:flutter/material.dart';

import 'constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key? key,
    required this.product,
    required this.price,
    required this.imageurl,
  }) : super(key: key);

  final String product;
  final double? price;
  final String? imageurl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Product name",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            product,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Price\n",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black,
                            )),
                    TextSpan(
                      text: "${price.toString()} \$ ",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              Expanded(
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Image.network(imageurl!),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
