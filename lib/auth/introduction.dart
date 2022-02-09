import 'package:course/auth/splash.dart';
import 'package:course/generated/l10n.dart';
import 'package:course/sitting/applanguse.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   Locale myLocale = Localizations.localeOf(context);
  //   print('my locale ${myLocale}');
  //   super.didChangeDependencies();
  // }

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacementNamed("login");
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'images/login.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: GestureDetector(
              child: _buildImage('language.png', 50),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? lan = prefs.getString('lang');
                if (lan == "en") {
                  prefs.setString("lang", "ar");
                  lan = "ar";
                } else {
                  prefs.setString("lang", "en");
                  lan = "en";
                }
                print("=====================================${lan}");
                // setState(() {
                //   S.load(Locale(lan!));
                // });
                //final provider =
                Provider.of<LocaleProvider>(context, listen: false)
                    .setLocale(Locale(lan));

                //provider.setLocale(Locale(lan!));
              },
            ),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "${S.of(context).flutter}",
          body: "${S.of(context).flutter_1}",
          image: _buildImage('intorduction.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "${S.of(context).flutter_3}",
          body: "${S.of(context).intro_22}",
          image: _buildImage('intorduction.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: Text(S.of(context).Skip),
      next: const Icon(Icons.arrow_forward),
      done: Text(S.of(context).Done, style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
