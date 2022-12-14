import 'package:flutter/material.dart';
import 'package:notes/model/notesModel.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/dataBaseHelper.dart';

class editNotesScreen extends StatefulWidget {
  editNotesScreen({Key? key, required this.notesData}) : super(key: key);

  late notesModel notesData;
  @override
  State<editNotesScreen> createState() => _editNotesScreenState();
}

class _editNotesScreenState extends State<editNotesScreen> {
  List<String> monthStr = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  late notesModel data;
  bool keyboardON = false;
  void initState() {
    super.initState();
    data = widget.notesData;
    if (data.id != 4004) {
      editing = true;
      textNoteController.text = data.noteString;
      if (data.deleted == true) {
        deleteNote = true;
      }
      if (data.pinned == true) {
        pinNote = true;
      }
    }
  }

  final textNoteController = TextEditingController();

  bool editing = false;
  bool pinNote = false;
  bool deleteNote = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: save(),
      child: Scaffold(
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
                lastModifiedPrint(),
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
                  // save();
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
    // if (MediaQuery.of(context).viewInsets.bottom == 0)
    if (editing == false) {
      textNoteController.text != ""
          ? DataBaseHelper.instance.insert({
              DataBaseHelper.noteStringText: textNoteController.text,
              DataBaseHelper.deletedBool: deleteNote ? 1 : 0,
              DataBaseHelper.pinnedBool: pinNote ? 1 : 0,
              DataBaseHelper.lastModifyDInt: DateTime.now().day,
              DataBaseHelper.lastModifyMInt: DateTime.now().month,
              DataBaseHelper.lastModifyYInt: DateTime.now().year,
              DataBaseHelper.lastModifyTHInt: DateTime.now().hour,
              DataBaseHelper.lastModifyTMInt: DateTime.now().minute,
            }, 0)
          : SizedBox();
    } else {
      textNoteController.text != ""
          ? DataBaseHelper.instance.update({
              "id": data.id,
              DataBaseHelper.noteStringText: textNoteController.text,
              DataBaseHelper.deletedBool: deleteNote ? 1 : 0,
              DataBaseHelper.pinnedBool: pinNote ? 1 : 0,
              DataBaseHelper.lastModifyDInt: DateTime.now().day,
              DataBaseHelper.lastModifyMInt: DateTime.now().month,
              DataBaseHelper.lastModifyYInt: DateTime.now().year,
              DataBaseHelper.lastModifyTHInt: DateTime.now().hour,
              DataBaseHelper.lastModifyTMInt: DateTime.now().minute,
            }, 0)
          : DataBaseHelper.instance.delete(data.id, 0);
    }
  }

  lastModifiedPrint() {
    if (data.id != 4004) {
      if (data.lastModifyD == DateTime.now().day &&
          data.lastModifyM == DateTime.now().month &&
          data.lastModifyY == DateTime.now().year) {
        return "Edited " +
            data.lastModifyTH.toString() +
            ":" +
            data.lastModifyTM.toString();
      } else {
        return "Edited " +
            data.lastModifyD.toString() +
            monthStr[data.lastModifyM - 1];
      }
    } else
      return "Edited " +
          DateTime.now().hour.toString() +
          ":" +
          DateTime.now().minute.toString();
  }
}
