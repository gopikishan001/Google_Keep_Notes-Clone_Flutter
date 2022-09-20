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

  Future<void> onrefresh() async {
    setState(() {});
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<List<notesModel>> loadData() async {
    List<Map<String, dynamic>> notesDB =
        await DataBaseHelper.instance.querryAll([], 0);

    return List.generate(notesDB.length, (index) {
      return notesModel(
        id: notesDB[index]["id"],
        deleted: notesDB[index][DataBaseHelper.deletedBool],
        pinned: notesDB[index][DataBaseHelper.pinnedBool],
        noteString: notesDB[index][DataBaseHelper.noteStringText],
        lastModifyD: notesDB[index][DataBaseHelper.lastModifyDInt],
        lastModifyM: notesDB[index][DataBaseHelper.lastModifyMInt],
        lastModifyY: notesDB[index][DataBaseHelper.lastModifyYInt],
      );
    });
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
                  Navigator.pushNamed(context, "searchScreen");
                  // onrefresh();
                },
                child: topBarHomeScreen(context, drawerKey)),
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
                              : const CircularProgressIndicator())),
            )
            // const SizedBox(height: 15),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: cardColor,
            onPressed: () {
              Navigator.pushNamed(context, "editNotesScreen");
            },
            child: const Icon(Icons.create, color: Colors.white)),
      ),
    );
  }
}

Widget viewBuilder(snapshot) {
  return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 100,
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8),
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
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
    onLongPress: () {},
    onTap: (() {
      editNotesScreen(notesData: data);
    }),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: white.withOpacity(0.5))),
      child: Text(
        data.noteString,
        style: const TextStyle(color: white),
      ),
    ),
  );
}

Container topBarHomeScreen(context, drawerKey) {
  return Container(
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
              color: black.withOpacity(0.2), spreadRadius: 2, blurRadius: 3)
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
                    style:
                        TextStyle(color: white.withOpacity(0.5), fontSize: 16),
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
              onPressed: () {},
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
