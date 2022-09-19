import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/screen/drawerScreen.dart';
import 'package:notes/utils/colors.dart';

class settingsScreen extends StatelessWidget {
  const settingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: drawerScreen(selectedVal: 4),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: bgColor,
          child: Column(
            children: [
              topBarSettingsScreen(context),
            ],
          ),
        ),
      ),
    );
  }

  Container topBarSettingsScreen(context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TextButton(
                style: editScreenButtonStyle(),
                onPressed: () {
                  // save();
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: white,
                ),
              ),
              const Text(
                "Settings",
                style: TextStyle(color: white, fontSize: 20),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                style: editScreenButtonStyle(),
                onPressed: () {},
                child: const CircleAvatar(
                  backgroundColor: white,
                ),
              ),
              const SizedBox(
                width: 15,
              )
            ],
          )
        ],
      ),
    );
  }

  ButtonStyle editScreenButtonStyle() {
    return ButtonStyle(
      overlayColor:
          MaterialStateColor.resolveWith((states) => white.withOpacity(0.1)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      )),
    );
  }
}
