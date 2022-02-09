import 'package:course/models/cart.dart';
import 'package:course/models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

showAlertDialog(BuildContext context, Item item) {
  final provider = Provider.of<Cart>(context, listen: false);
  TextEditingController? _textcontroller =
      TextEditingController(text: item.count.toString());

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 0,
    title: const Text(
        "Press delete to remove item or enter a new count item and press update..."),
    content: Row(
      children: [
        const Expanded(
          child: Text("New count : "),
        ),
        Expanded(
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
              ),
            ),
            controller: _textcontroller,
          ),
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            child: const Text("DELETE"),
            onPressed: () {
              provider.deleteItem(item);
              //Put your code here which you want to execute on Yes button click.
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("UPDATE"),
            onPressed: () {
              if (_textcontroller.text.isNotEmpty) {
                provider.deletePrice(item);
                item.count = int.tryParse(_textcontroller.text)!;
                provider.updateCountOfItem(item);
              }
              //Put your code here which you want to execute on No button click.
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("CANCEL"),
            onPressed: () {
              //Put your code here which you want to execute on Cancel button click.
              Navigator.of(context).pop();
            },
          ),
        ],
      )
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
