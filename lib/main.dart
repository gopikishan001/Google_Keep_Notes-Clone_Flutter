import 'package:flutter/material.dart';
import 'package:notes/screen/deletedScreen.dart';
import 'package:notes/screen/editNotes.dart';
import 'package:notes/screen/helpScreen.dart';
import 'package:notes/screen/homeScreen.dart';
import 'package:notes/screen/pinnedScreen.dart';
import 'package:notes/screen/searchScreen.dart';
import 'package:notes/screen/settings.dart';

import 'model/notesModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: "editNotesScreen",
      routes: {
        "pinnedScreen": (context) => (pinnedScreen()),
        "homeScreen": (context) => (homeScreen()),
        "settingsScreen": (context) => (settingsScreen()),
        "searchScreen": (context) => (const searchScreen()),
        "editNotesScreen": (context) => (editNotesScreen(
              notesData: notesModel(),
            )),
        "helpScreen": (context) => (helpScreen()),
        "deletedScreen": (context) => (deletedScreen()),
      },
      home: homeScreen(),
    );
  }
}
