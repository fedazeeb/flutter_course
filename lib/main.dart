import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course/auth/splash.dart';
import 'package:course/home/product.dart';
import 'package:course/models/cart.dart';
import 'package:course/sitting/applanguse.dart';
import 'package:course/sitting/webview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

import 'auth/introduction.dart';
import 'auth/login.dart';
import 'auth/signup.dart';
import 'auth/validation.dart';
import 'home/category.dart';
import 'home/checkout.dart';
import 'home/editprofile.dart';
import 'home/homepage.dart';
import 'home/search.dart';
import 'models/users.dart';

bool? isLogin;

void main() async {
  // initial firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    isLogin = true;
  } else {
    isLogin = false;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
      ],
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        // provider.changeLanguages();
        print("-----------------------");
        print(provider.locale);
        print("///////////////////////////////////");
        provider.fetchLocale();

        return MaterialApp(
          //  debugShowCheckedModeBanner: false,
          title: "language",
          // theme: ThemeData.light(),
          // ThemeData(
          //     //scaffoldBackgroundColor: Colors.deepPurple.shade100,
          //     // primaryColor: Colors.deepPurpleAccent,
          //     ),
          // darkTheme: provider.darkTheme,
          // ThemeData.light(),
          locale: provider.locale,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            S.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: //isLogin == false ? SplashScreen() : Category(),
              // EditProfile(),
              Login(),
          routes: {
            'login': (context) => Login(),
            'splashscreen': (context) => SplashScreen(),
            'signup': (context) => Signup(),
            "validations": (context) => Validations(),
            "homepage": (context) => HomePage(),
            "product": (context) => Product(),
            "category": (context) => Category(),
            "myrequest": (context) => Checkout(),
            "onboardingpage": (context) => OnBoardingPage(),
            WebViewExample.routeName: (context) => WebViewExample(),
            "search": (context) => Search(),
            "editprofile": (context) => EditProfile(),
          },
        );
      },
    );
  }
}
