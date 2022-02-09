import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'applanguse.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({Key? key}) : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Switch(
      onChanged: (bool value) {
        if (isSwitch == false) {
          setState(() {
            provider.setDarkMode(ThemeData.light());
            isSwitch = true;
          });
        } else {
          setState(() {
            provider.setDarkMode(ThemeData.dark());
            isSwitch = false;
          });
        }
      },
      value: isSwitch,
    );
  }
}
