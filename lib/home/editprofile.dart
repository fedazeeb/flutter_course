import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course/componet/constants.dart';
import 'package:course/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  final Users _user = Users(
      username: "",
      email: "",
      users: FirebaseFirestore.instance.collection('users'),
      password: '', age: 20);

  updatefunction(String oldEmail) async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      try {
        formdata.save();
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: oldEmail, password: _user.password);
        print("============ Success =======================");
        User? user = FirebaseAuth.instance.currentUser;
        print(_user.email);

        user!.updateEmail(_user.email).then((_){
          print("Successfully changed password");
        }).catchError((error){
          print("Password can't be changed" + error.toString());
          //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.

        });
        //////////////////////////////////////////
       // _user.addUser();

        CollectionReference userRef =
        FirebaseFirestore.instance.collection("users");
        userRef.doc("Q44JhxNzzAijqveKxK4I").update({
          "age": _user.age,
          "email": _user.email,
          "username": _user.username,
        });
        print("----------------********************");

        Navigator.of(context).pushReplacementNamed("category");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
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
    }
  }

  void _changePassword(String password) async {
    var user =
        FirebaseAuth.instance.currentUser;
    String email = '';
    email = user!.email!;

    //Create field for user to input old password

    //pass the password here
    String password = "password";
    String newPassword = "password";

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user.updatePassword(newPassword).then((_){
        print("Successfully changed password");
      }).catchError((error){
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    // GlobalKey<FormState> formstate = new GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc('Q44JhxNzzAijqveKxK4I')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!.data();
              return Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    alignment: Alignment.center,
                    height: h * 0.25,
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 90,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Image.network(
                                "http://assets.stickpng.com/images/580b585b2edbce24c47b2836.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        // const Align(
                        //   alignment: Alignment.bottomRight,
                        //   child:
                        Positioned(
                          height: (h * 0.25) * 1.5,
                          width: (w * 1.35),
                          child: IconButton(
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 35,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: h,
                    margin: EdgeInsets.only(top: h * 0.233),
                    padding: EdgeInsets.only(
                      top: h * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin,
                      // bottom: h * 0.12,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formstate,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // username TFF
                            Card(
                              child: TextFormField(
                                validator: (val) {
                                  if (val!.length > 10) {
                                    return "The username more than 10 character";
                                  }
                                  if (val.length < 2) {
                                    return "The username less than 2 character";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  _user.username = val!;
                                },
                                initialValue: data!['username'],
                                // autofocus: true,
                                // textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    hintText: "Enter Username",
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // email TFF
                            Card(
                              child: TextFormField(
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
                                initialValue: data['email'],
                                // readOnly: true,
                                keyboardType: TextInputType.emailAddress,
                                // textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: "Enter Email",
                                  prefixIcon: Icon(Icons.password),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // password TFF
                            Card(
                              child: TextFormField(
                                validator: (value) {},
                                onSaved: (val) {
                                  _user.age = int.tryParse(val!)! ;
                                },
                                // obscureText: true,
                                keyboardType: TextInputType.number,
                                initialValue: data['age'].toString(),
                                // textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    hintText: "Enter Password",
                                    prefixIcon: Icon(Icons.password),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              child: TextFormField(
                                validator: (val) {
                                  _user.password = val!;
                                },
                                onSaved: (val) {
                                  _user.password = val!;
                                },
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: "Enter Password",
                                    prefixIcon: Icon(Icons.password),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1),
                                    )),
                              ),
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
                                  onTap: () async {},
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
                                   /* var user =
                                        FirebaseAuth.instance.currentUser;


                                    await user!
                                        .updateEmail("user@example.com")
                                        .then((value) => {})
                                        .catchError((error) {
                                      print("Password can't be changed" +
                                          error.toString());
                                      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                                    });
                                    print("true");*/
                                    // final List<DocumentSnapshot> documents =
                                    //     snapshot.data!.docs;
                                    // var s = documents.map((e) => null).toList();
                                    // print(s['email']);
                                    // snapshot.data!.docs.forEach((element) {
                                    //   var s = element.data();

                                    // print({s["username"]});
                                    // });
                                   /* var userDocument = snapshot.data;
                                    var data = snapshot.data!.data();
                                    var value = data!['email'];
                                    print("one document ${value}");*/
                                    print(data['email']);
                                    updatefunction(data['email']);
                                  },
                                  child: Text("Update Account")),
                            ),
                            Text(" "
                                // "$signupResult"
                                " "),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else
              return Text("Loading");
          }),
    );
  }
}
