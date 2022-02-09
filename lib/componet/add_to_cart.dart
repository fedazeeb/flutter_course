import 'package:flutter/material.dart';
import 'constants.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
    //@required this.product,
  }) : super(key: key);

  // final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.black,
                //product.color,
              ),
            ),
            child: IconButton(
              icon: new Icon(Icons.more_vert),
              tooltip: 'Navigation menu',
              onPressed: () {},
            ),
            //  onPressed: () {},
            ),
        //  ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
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
    );
  }
}