import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/model/notesModel.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/dataBaseHelper.dart';

import 'drawerScreen.dart';

class editNotesScreen extends StatefulWidget {
  editNotesScreen({Key? key}) : super(key: key);

  @override
  State<editNotesScreen> createState() => _editNotesScreenState();
}

class _editNotesScreenState extends State<editNotesScreen> {
  final textNoteController = TextEditingController();

  bool pinNote = false;

  bool deleteNote = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: save(),
      child: Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        //   backgroundColor: bgColor,
        //   actions: const [Icon(Icons.pin_drop_outlined), SizedBox(width: 15)],
        // ),
        body: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: bgColor,
              child: Column(
                children: [
                  topBarEditScreen(context),
                  mainEditWindow(context),
                  bottomBarEditScreen(context),
                ],
              )),
        ),
      ),
    );
  }

  SingleChildScrollView mainEditWindow(context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - 160,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: TextFormField(
          controller: textNoteController,
          maxLines: null,
          cursorColor: white,
          style: const TextStyle(color: white),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusColor: white,
              hintText: "Note",
              hintStyle: TextStyle(color: white.withOpacity(0.5)),
              fillColor: white),
        ),
      ),
    );
  }

  Container bottomBarEditScreen(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
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
                onPressed: () {},
                child: Icon(
                  Icons.color_lens_outlined,
                  color: white.withOpacity(0.7),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Last edited",
                style: TextStyle(color: white.withOpacity(0.7)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                style: editScreenButtonStyle(),
                onPressed: () {},
                child: Icon(
                  Icons.more_vert,
                  color: white.withOpacity(0.7),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container topBarEditScreen(context) {
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
                  save();
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: white,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                style: editScreenButtonStyle(),
                onPressed: () {
                  pinNote = !pinNote;
                  setState(() {});
                },
                child: pinNote
                    ? const Icon(
                        Icons.pin_drop,
                        color: white,
                      )
                    : const Icon(
                        Icons.pin_drop_outlined,
                        color: white,
                      ),
              ),
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

  save() {
    textNoteController.text != ""
        ? DataBaseHelper.instance.insert({
            DataBaseHelper.noteStringText: textNoteController.text,
            DataBaseHelper.deletedBool: deleteNote ? 1 : 0,
            DataBaseHelper.pinnedBool: pinNote ? 1 : 0,
            DataBaseHelper.lastModifyDInt: DateTime.now().day,
            DataBaseHelper.lastModifyMInt: DateTime.now().month,
            DataBaseHelper.lastModifyYInt: DateTime.now().year,
          }, 0)
        : SizedBox();
  }
}
