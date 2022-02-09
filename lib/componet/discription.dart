import 'package:flutter/material.dart';

import 'constants.dart';

class Description extends StatefulWidget {
  final String? dummyText;

  const Description({
    Key? key,
    required this.dummyText,
    // @required this.product,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late ScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // String dummyText = //"Test";
    //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
    return Scrollbar(
      thickness: 7,
      isAlwaysShown: true,
     // showTrackOnHover: true,
      radius: Radius.circular(10),
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: kDefaultPaddin, horizontal: kDefaultPaddin / 2),
          child: Text(
            //product.description,
            widget.dummyText.toString(),
            style: TextStyle(height: 1.5, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
