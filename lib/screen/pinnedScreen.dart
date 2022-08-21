import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/screen/drawerScreen.dart';
import 'package:notes/utils/colors.dart';

class pinnedScreen extends StatelessWidget {
  const pinnedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cardColor,
      ),
      drawer: drawerScreen(selectedVal: 2),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: bgColor,
        child: Text(
          "Pinned",
          style: TextStyle(color: white, fontSize: 30),
        ),
      ),
    );
  }
}
