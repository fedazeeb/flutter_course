import 'package:course/sitting/switchwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'applanguse.dart';

class MyDrawer extends StatelessWidget {
  int pagenumber;

  MyDrawer({required this.pagenumber});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          InkWell(
            child: DrawerHeader(
              margin: EdgeInsets.only(top: 16.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("images/login.png"))),
                    ),
                    Text("Avinash Kumar",
                        style: TextStyle(color: Colors.black, fontSize: 18.0)),
                    Text("avinash.mindiii@gmail.com")
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () {
              // Navigator.of(context)
              //     .pushNamed("category");
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Home clicked"),
              ));
            },
            selected: true,
          ),
          ListTile(
            title: Text("History"),
            leading: Icon(Icons.history),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("homepage");
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("History clicked"),
              ));
            },
          ),
          ListTile(
            title: Text("Account"),
            leading: Icon(Icons.account_circle),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("editprofile");

              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Account clicked"),
              ));
            },
          ),
          Divider(),
          ExpansionTile(
            title: Text("language"),
            leading: const Icon(Icons.language),
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 7,
                    right: MediaQuery.of(context).size.width / 9),
                child: Card(
                  margin: EdgeInsets.all(0),
                  child: ListTile(
                    title: const Text("English"),
                    leading: Image.network(
                      "http://assets.stickpng.com/images/580b585b2edbce24c47b2836.png",
                      width: 30,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("lang", "en");
                      provider.setLocale(Locale("en"));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                              "The language has been changed to English"),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 7,
                    right: MediaQuery.of(context).size.width / 9),
                child: Divider(
                  color: Colors.black38,
                  indent: 75,
                  height: 2.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 7,
                    right: MediaQuery.of(context).size.width / 9),
                child: Card(
                  margin: EdgeInsets.all(0),
                  child: ListTile(
                      title: const Text("عربي"),
                      leading: Image.network(
                        "https://cdn1.vectorstock.com/i/1000x1000/47/90/syria-flag-button-vector-1994790.jpg",
                        width: 30,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("lang", "ar");
                        provider.setLocale(Locale("ar"));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("تم تغيير اللغة الى العربي"),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 7,
                    right: MediaQuery.of(context).size.width / 9),
                child: Divider(
                  color: Colors.black38,
                  indent: 75,
                  height: 1.0,
                ),
              ),
            ],
          ),
          ListTile(
            title: Text("Dark Mode"),
            leading: Icon(Icons.wb_sunny_outlined),
            onTap: () {
              Navigator.pop(context);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Share clicked"),
                ),
              );
            },
            trailing: SwitchWidget(),
            selected: false,
          ),
          Divider(),
          ListTile(
            title: Text("Share"),
            leading: Icon(Icons.share),
            onTap: () {
              Navigator.pop(context);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Share clicked"),
              ));
            },
            selected: false,
          ),
          ListTile(
            title: Text("About"),
            leading: Icon(Icons.info),
            onTap: () {
              Navigator.pop(context);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("About clicked"),
              ));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.exit_to_app),
            onTap: () async {
              Navigator.of(context).pop();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              Scaffold.of(context).showSnackBar(const SnackBar(
                content: Text("You are logged out"),
              ));
            },
          ),
        ],
      ),
    );
  }
}
