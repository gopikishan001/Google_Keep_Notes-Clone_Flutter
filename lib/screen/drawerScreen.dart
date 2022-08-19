// ignore_for_file: camel_case_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                1, Icons.lightbulb_outline, "Notes", selectedVal),
            drawerContainerDesign(
                2, Icons.archive_outlined, "Archive", selectedVal),
            drawerContainerDesign(
                3, Icons.delete_outline, "Deleted", selectedVal),
            drawerContainerDesign(4, Icons.settings, "Settings", selectedVal),
            drawerContainerDesign(
                5, Icons.question_mark, "Help & feedback", selectedVal),
          ],
        )),
      ),
    );
  }
}

Container drawerContainerDesign(val, icon, text, selectedVal) {
  return Container(
    height: 45,
    padding: const EdgeInsets.only(right: 20),
    child: TextButton(
      onPressed: () {},
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
