import 'package:course/generated/l10n.dart';
import 'package:course/sitting/logs.dart';
import 'package:course/sitting/logssqflitedb.dart';
import 'package:course/sitting/student.dart';
import 'package:course/sitting/studentsqflitedb.dart';
import 'package:course/sitting/logstorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  late String my_password, my_email;
  LogStorage storage = LogStorage();

  final DBLogsManager dbStudentManager = DBLogsManager();
  final DBActionLogsManager dbactionlogsManager = DBActionLogsManager();

  SingInfunction() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: my_email,
            password: my_password
        );
        Navigator.of(context)
            .pushReplacementNamed("category");
        // homepage Product
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  // Locale? myLocale;
  // @override
  // void didChangeDependencies() {
  //   var newLocal = Localizations.localeOf(context);
  //   if(myLocale != newLocal)
  //     myLocale = newLocal;
  //   print('my locale ${myLocale}');
  //   super.didChangeDependencies();
  // }

  late FocusNode femail,fpassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    femail = FocusNode();
    fpassword = FocusNode();
  }

  void dispose(){
    femail.dispose();
    fpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('images/login.png'),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formstate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val!.length > 30) {
                            return "The email more than 30 character";
                          }
                          if (val.length < 2) {
                            return "The email less than 10 character";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          my_email = val!;
                        },
                        focusNode: femail,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: S.of(context).enteremail,
                          prefixIcon: const Icon(Icons.person),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.length > 10) {
                            return "The Password more than 10 character";
                          }
                          if (val.length < 2) {
                            return "The Password less than 10 character";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          my_password = val.toString();
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: S.of(context).enterpassword,
                            prefixIcon: const Icon(Icons.password),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(S.of(context).login),
                          InkWell(
                            child: Text(
                              "${S.of(context).clickhere}",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 25.0),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed("signup");
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              textStyle: const TextStyle(
                                //color: Colors.black,
                                fontSize: 20.0,
                              ),
                            ),
                            onPressed: () async {
                              // Navigator.of(context)
                              //     .pushReplacementNamed("homepage");
                              // storage.writeLogFile("fedaaa");
                              // String? ll = await storage.readLogFile();
                              // print(ll);

                              // ActionLogs st =
                              //     ActionLogs(name: 'feda', course: 'flutter');
                              // dbStudentManager
                              //     .insertStudent(st)
                              //     .then((value) => {
                              //           print(
                              //               "Student Data Add to database $value"),
                              //         });
                              DateTime now = new DateTime.now();
                              Logs lo = Logs(
                                  username: 'feda',
                                  actionname: 'login',
                                  date: now.toString());
                              dbactionlogsManager
                                  .insertLog(lo)
                                  .then((value) => print(value));
                              // dbStudentManager
                              //     .openDB()
                              //     .then((value) => print(value));
                              // List<Logs> ll =  await dbactionlogsManager.getLogList();
                              // print(ll[0].date);
                              await SingInfunction();
                            },
                            child: const Text("Login")),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
