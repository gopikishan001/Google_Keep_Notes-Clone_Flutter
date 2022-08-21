import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/utils/colors.dart';

import 'drawerScreen.dart';

class deletedScreen extends StatelessWidget {
  const deletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cardColor,
      ),
      drawer: drawerScreen(selectedVal: 3),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: bgColor,
        child: Text(
          "Deleted",
          style: TextStyle(color: white, fontSize: 30),
        ),
      ),
    );
  }
}
