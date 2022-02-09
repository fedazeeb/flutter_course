import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Validations extends StatefulWidget {
  const Validations({Key? key}) : super(key: key);

  @override
  _ValidationsState createState() => _ValidationsState();
}

class _ValidationsState extends State<Validations> {
  String pin = "";

  @override
  void initState() {
    // TODO: implement initState
    pin = generateRandomString(6);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Validations"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Enter Pin Code"),
              Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.all(0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.blue],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    pin,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (val) {
                    print('${val}');
                  },
                  onCompleted: (val) {
                    print(val);
                    if (val == pin) {
                      Navigator.of(context).pushReplacementNamed("category");
                    }
                  },
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.blue.shade50,
                  //enableActiveFill: true,
                  controller: textEditingController,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    pin = generateRandomString(6);
                    print(pin);
                    User? user = FirebaseAuth.instance.currentUser;
                    print(user);
                  });
                },
                child: const Text("Generate Pin Code"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

void _showSnackBar(String pin, context) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: 3),
    content: Container(
      height: 80.0,
      child: Center(
        child: Text(
          'Pin Submitted. Value: $pin',
          style: const TextStyle(fontSize: 25.0),
        ),
      ),
    ),
    backgroundColor: Colors.deepPurpleAccent,
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
