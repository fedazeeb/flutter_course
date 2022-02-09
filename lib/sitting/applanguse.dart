import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale("en");
  ThemeData _darkTheme = ThemeData.dark();

  // = Locale("en");

  // LocaleProvider() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print(prefs.getString('lang'));
  //   _locale = Locale(prefs.getString('lang')!);
  // }

  Locale get locale => _locale;
  ThemeData get darkTheme => _darkTheme;

  // Future<Locale> getFromShared() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //   print(prefs.getString('lang'));
  //   //   _locale = Locale(prefs.getString('lang')!);
  //   return  Locale(prefs.getString('lang')!);
  // }

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    // print("++++++++++++++++++++++++++++++");
    // print(prefs.getString('lang'));
    if (prefs.getString('lang') == null) {
      _locale = Locale('en');
      prefs.setString("lang", "en");
      return Null;
    }
    if (_locale != Locale(prefs.getString('lang')!)) {
      _locale = Locale(prefs.getString('lang')!);
      notifyListeners();
    }
    return Null;
  }

  void setLocale(Locale locale) {
    //  if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void setDarkMode(ThemeData themeData){
    _darkTheme = themeData;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale("en");
    notifyListeners();
  }

  void changeLanguages() async {
    //(prefs.getString('lang') ?? "en");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('lang'));
    _locale = Locale(prefs.getString('lang')!);
    // notifyListeners();
  }
}
