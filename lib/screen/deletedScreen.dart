import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/model/notesModel.dart';
import 'package:notes/screen/editNotes.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/dataBaseHelper.dart';

import 'drawerScreen.dart';

class deletedScreen extends StatefulWidget {
  deletedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<deletedScreen> createState() => _deletedScreenState();
}

class _deletedScreenState extends State<deletedScreen> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  bool selecting = false;
  List selectedList = [];
  List<notesModel> listData = [];

  bool gridView = true;

  Future<void> onrefresh() async {
    setState(() {});
    return Future.delayed(const Duration(milliseconds: 700));
  }

  Future<List<notesModel>> loadData() async {
    List<Map<String, dynamic>> notesDB =
        await DataBaseHelper.instance.querryAll([], 0);

    listData.clear();
    for (int index = 0; index < notesDB.length; index++) {
      if (notesDB[index][DataBaseHelper.deletedBool] == 1) {
        listData.add(notesModel(
          id: notesDB[index]["id"],
          deleted: notesDB[index][DataBaseHelper.deletedBool],
          pinned: notesDB[index][DataBaseHelper.pinnedBool],
          noteString: notesDB[index][DataBaseHelper.noteStringText],
          lastModifyD: notesDB[index][DataBaseHelper.lastModifyDInt],
          lastModifyM: notesDB[index][DataBaseHelper.lastModifyMInt],
          lastModifyY: notesDB[index][DataBaseHelper.lastModifyYInt],
        ));
      }
    }
    return listData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: drawerScreen(selectedVal: 3),
        endDrawerEnableOpenDragGesture: true,
        key: drawerKey,
        backgroundColor: bgColor,
        body: Column(
          children: [
            GestureDetector(
                onTap: () {
                  selecting == true
                      ? const SizedBox()
                      : Navigator.pushNamed(context, "searchScreen");
                },
                child: topBarDeletedScreen(context, drawerKey)),
            RefreshIndicator(
              onRefresh: () {
                return onrefresh();
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 116,
                  child: FutureBuilder(
                      future: loadData(),
                      builder: (BuildContext context,
                              AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ? snapshot.data!.isNotEmpty
                                  ? viewBuilder(snapshot)
                                  : const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        "No notes Deleted",
                                        style: TextStyle(color: white),
                                      ),
                                    )
                              : const Center(
                                  child: CircularProgressIndicator(
                                  color: white,
                                )))),
            )
            // const SizedBox(height: 15),
          ],
        ),
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
                  selecting == true
                      ? {
                          selecting = false,
                          selectedList.clear(),
                          setState(() {})
                        }
                      : drawerKey.currentState!.openDrawer();
                },
                child: Icon(
                  selecting == true ? Icons.arrow_back : Icons.menu,
                  color: white,
                ),
              ),
              Text(
                selecting == true
                    ? selectedList.length.toString()
                    : "Deleted Notes",
                style: const TextStyle(color: white, fontSize: 20),
              )
            ],
          ),
          const SizedBox(width: 30),
          selecting == false
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      style: editScreenButtonStyle(),
                      onPressed: () {
                        for (int i = 0; i < selectedList.length; i++) {
                          DataBaseHelper.instance.update({
                            "id": selectedList[i],
                            DataBaseHelper.deletedBool: 0,
                          }, 0);
                        }
                        selectedList.clear();
                        selecting = false;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.restore,
                        color: white,
                      ),
                    ),
                    TextButton(
                        style: editScreenButtonStyle(),
                        onPressed: () {
                          for (int i = 0; i < selectedList.length; i++) {
                            DataBaseHelper.instance.delete(selectedList[i], 0);
                          }
                          selectedList.clear();
                          selecting = false;
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          color: white,
                        ))
                  ],
                )
        ],
      ),
    );
  }

  Widget viewBuilder(snapshot) {
    return gridView
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 100,
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return notesViewItem(snapshot.data![index]);
            })
        : ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, index) {
              return notesViewItem(snapshot.data![index]);
            });
  }

  Widget notesViewItem(data) {
    return InkWell(
      onLongPress: () {
        selecting = true;
        selectingTouch(data);
      },
      onTap: (() {
        selecting
            ? selectingTouch(data)
            // : Navigator.pushNamed(context, "editNotesScreen",
            //     arguments: {"notesData" == data});
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => editNotesScreen(notesData: data),
                ));
      }),
      child: Container(
        height: 80,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: selecting && selectedList.contains(data.id)
                ? Colors.white.withOpacity(0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: white.withOpacity(0.5))),
        child: Text(
          data.noteString,
          style: const TextStyle(color: white),
        ),
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

  selectingTouch(data) {
    if (!selectedList.contains(data.id)) {
      selectedList.add(data.id);
    } else {
      selectedList.remove(data.id);
      if (selectedList.isEmpty) {
        selecting = false;
      }
    }
    setState(() {});
  }
}
