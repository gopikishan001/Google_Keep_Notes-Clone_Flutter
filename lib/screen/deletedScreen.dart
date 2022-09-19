import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/utils/colors.dart';

import 'drawerScreen.dart';

class deletedScreen extends StatelessWidget {
  deletedScreen({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: drawerKey,
        drawer: drawerScreen(selectedVal: 3),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: bgColor,
            child: Column(
              children: [topBarDeletedScreen(context, drawerKey)],
            )),
      ),
    );
  }

  Container topBarDeletedScreen(context, drawerKey) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                  // Navigator.pop(context);
                  drawerKey.currentState!.openDrawer();
                },
                child: const Icon(
                  Icons.menu,
                  color: white,
                ),
              ),
              const Text(
                "Deleted Notes",
                style: TextStyle(color: white, fontSize: 20),
              )
            ],
          ),
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
