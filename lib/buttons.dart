import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constraints/constants.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({Key? key}) : super(key: key);

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool nightMode = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: nightMode,
      inactiveTrackColor: Colors.black,
      activeColor: Colors.white,
      activeThumbImage: const AssetImage("night_mode.png"),
      inactiveThumbImage: const AssetImage("light_mode.png"),
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          nightMode = value;
          itsNight = !itsNight;
          // modeChange(nightMode);
          // ModeButton(false);
        });
      },
    );
  }
}
