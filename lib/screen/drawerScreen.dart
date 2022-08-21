// ignore_for_file: camel_case_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/screen/pinnedScreen.dart';
import 'package:notes/utils/colors.dart';

class drawerScreen extends StatelessWidget {
  drawerScreen({Key? key, required this.selectedVal}) : super(key: key);

  int selectedVal;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(color: bgColor),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const Text(
              "Notes",
              style: TextStyle(
                  color: white, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
              child: Divider(color: white.withOpacity(0.5)),
            ),
            drawerContainerDesign(
                context, 1, Icons.lightbulb_outline, "Notes", selectedVal),
            drawerContainerDesign(context, 2, Icons.pin_drop_outlined,
                "Pinned Notes", selectedVal),
            drawerContainerDesign(
                context, 3, Icons.delete_outline, "Deleted", selectedVal),
            drawerContainerDesign(
                context, 4, Icons.settings, "Settings", selectedVal),
            drawerContainerDesign(context, 5, Icons.question_mark,
                "Help & feedback", selectedVal),
          ],
        )),
      ),
    );
  }
}

Container drawerContainerDesign(context, val, icon, text, selectedVal) {
  return Container(
    height: 45,
    padding: const EdgeInsets.only(right: 20),
    child: TextButton(
      onPressed: () {
        val == 1
            ? Navigator.pushNamed(context, "homeScreen")
            : val == 2
                ? Navigator.pushNamed(context, "pinnedScreen")
                : val == 3
                    ? Navigator.pushNamed(context, "deletedScreen")
                    : val == 4
                        ? Navigator.pushNamed(context, "settingsScreen")
                        : val == 5
                            ? Navigator.pushNamed(context, "helpScreen")
                            : SizedBox();
      },
      style: drawerScreenButtonStyle(selectedVal == val ? true : false),
      child: Row(children: [
        const SizedBox(width: 10),
        Icon(
          icon,
          color: white.withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(fontSize: 17, color: white.withOpacity(0.7)),
        )
      ]),
    ),
  );
}

ButtonStyle drawerScreenButtonStyle(selected) {
  return ButtonStyle(
    backgroundColor: selected
        ? MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.4))
        : MaterialStateProperty.all(Colors.transparent),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)))),
  );
}
