import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/utils/colors.dart';

import 'drawerScreen.dart';

class helpScreen extends StatelessWidget {
  const helpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: drawerScreen(selectedVal: 5),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: bgColor,
          child: Column(
            children: [
              topBarHelpScreen(context),
            ],
          ),
        ),
      ),
    );
  }

  Container topBarHelpScreen(context) {
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
                "Help and feedback",
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
