import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  RegExp digitValidator =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  late String signupResult = "";
  final Users _user = Users(
      username: "",
      email: "",
      users: FirebaseFirestore.instance.collection('users'),
      password: '', age: 20);
  TextEditingController email = TextEditingController();

  singUPfunction() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _user.email, password: _user.password);
        print("============ Success =======================");
        User? user = FirebaseAuth.instance.currentUser;
        print(user);
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
        }
        //////////////////////////////////////////
        _user.addUser();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      // await FirebaseAuth.instance.verifyPhoneNumber(
      //   phoneNumber: '+963 0993 991 503',
      //   verificationCompleted: (PhoneAuthCredential credential) {},
      //   verificationFailed: (FirebaseAuthException e) {},
      //   codeSent: (String verificationId, int? resendToken) {},
      //   codeAutoRetrievalTimeout: (String verificationId) {},
      // );
      Navigator.of(context).pushReplacementNamed("validations");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SignUp"),
        ),
        body: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: formstate,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // username TFF
                          TextFormField(
                            validator: (val) {
                              if (val!.length > 10) {
                                return "The username more than 10 character";
                              }
                              if (val.length < 2) {
                                return "The username less than 10 character";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              _user.username = val!;
                            },
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                hintText: "Enter Username",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // email TFF
                          TextFormField(
                            validator: (val) {
                              if (val!.length > 30)
                                return "The email more than 30 character";
                              if (val.length < 2)
                                return "The email less than 10 character";
                              return null;
                            },
                            onSaved: (val) {
                              _user.email = val!;
                            },
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Enter Email",
                              prefixIcon: Icon(Icons.password),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // password TFF
                          TextFormField(
                            validator: (value) {
                              if (digitValidator.hasMatch(value!)) {
                                //  return 'Good Password';
                                _user.password = value;
                              } else {
                                return 'Week Password';
                              }
                            },
                            onSaved: (val) {
                              _user.password = val.toString();
                            },
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                hintText: "Enter Password",
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val != _user.password) {
                                return "Not Matched Password";
                              }
                            },
                            onSaved: (val) {},
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: "Confirm Password",
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text("If you have account   "),
                              InkWell(
                                child: Text(
                                  "Click here !",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onTap: () async {
                                  UserCredential userCredential =
                                      await FirebaseAuth.instance
                                          .signInAnonymously();
                                  Navigator.of(context).pushNamed("login");
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Sign up bottom
                          Container(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    textStyle: TextStyle(
                                      //color: Colors.black,
                                      fontSize: 20.0,
                                    )),
                                onPressed: () async {
                                  //showLoading(context);
                                  // Navigator.of(context).pushNamed("validations");
                                  singUPfunction();
                                },
                                child: Text("Create Account")),
                          ),
                          Text(" $signupResult "),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Wait"),
          content: Container(
              height: 50,
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              )),
        );
      });
}
