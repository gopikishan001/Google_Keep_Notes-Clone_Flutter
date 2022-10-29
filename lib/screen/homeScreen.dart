import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/model/notesModel.dart';
import 'package:notes/screen/drawerScreen.dart';
import 'package:notes/screen/editNotes.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/dataBaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class homeScreen extends StatefulWidget {
  homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
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
      if (notesDB[index][DataBaseHelper.deletedBool] != 1) {
        listData.add(notesModel(
          id: notesDB[index]["id"],
          deleted: notesDB[index][DataBaseHelper.deletedBool],
          pinned: notesDB[index][DataBaseHelper.pinnedBool],
          noteString: notesDB[index][DataBaseHelper.noteStringText],
          lastModifyD: notesDB[index][DataBaseHelper.lastModifyDInt],
          lastModifyM: notesDB[index][DataBaseHelper.lastModifyMInt],
          lastModifyY: notesDB[index][DataBaseHelper.lastModifyYInt],
          lastModifyTH: notesDB[index][DataBaseHelper.lastModifyTHInt],
          lastModifyTM: notesDB[index][DataBaseHelper.lastModifyTMInt],
        ));
      }
    }
    return listData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: drawerScreen(selectedVal: 1),
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
                  child: topBarHomeScreen(context)),
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
                                          "No notes added",
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
          floatingActionButton: !selecting
              ? FloatingActionButton(
                  backgroundColor: cardColor,
                  onPressed: () {
                    Navigator.pushNamed(context, "editNotesScreen");
                  },
                  child: const Icon(Icons.create, color: Colors.white))
              : const SizedBox()),
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

  ButtonStyle homeScreenButtonStyle() {
    return ButtonStyle(
      overlayColor:
          MaterialStateColor.resolveWith((states) => white.withOpacity(0.1)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      )),
    );
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

  Container topBarHomeScreen(context) {
    return selecting == true
        ? Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextButton(
                      style: homeScreenButtonStyle(),
                      onPressed: () {
                        selecting = false;
                        selectedList.clear();
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      selectedList.length.toString(),
                      style: const TextStyle(
                          color: white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(width: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      style: homeScreenButtonStyle(),
                      onPressed: () {
                        for (int i = 0; i < selectedList.length; i++) {
                          DataBaseHelper.instance.update({
                            "id": selectedList[i],
                            DataBaseHelper.pinnedBool: 1,
                          }, 0);
                          // DataBaseHelper.instance.delete(selectedList[i], 0);
                        }
                        selectedList.clear();
                        selecting = false;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.pin_drop_outlined,
                        color: white,
                      ),
                    ),
                    TextButton(
                        style: homeScreenButtonStyle(),
                        onPressed: () {
                          for (int i = 0; i < selectedList.length; i++) {
                            DataBaseHelper.instance.update({
                              "id": selectedList[i],
                              DataBaseHelper.deletedBool: 1,
                            }, 0);
                            // DataBaseHelper.instance.delete(selectedList[i], 0);
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
          )
        : Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextButton(
                      style: homeScreenButtonStyle(),
                      onPressed: () {
                        drawerKey.currentState!.openDrawer();
                      },
                      child: const Icon(
                        Icons.menu,
                        color: white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Search Your Notes",
                            style: TextStyle(
                                color: white.withOpacity(0.5), fontSize: 16),
                          )
                        ]),
                  ],
                ),
                // const SizedBox(width: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      style: homeScreenButtonStyle(),
                      onPressed: () {
                        gridView = !gridView;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.grid_view,
                        color: white,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      style: homeScreenButtonStyle(),
                      onPressed: () {},
                      child: const CircleAvatar(
                        backgroundColor: white,
                      ),
                    )
                  ],
                )
              ],
            ),
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
