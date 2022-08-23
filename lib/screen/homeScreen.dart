import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/screen/drawerScreen.dart';
import 'package:notes/utils/colors.dart';

class homeScreen extends StatelessWidget {
  homeScreen({Key? key}) : super(key: key);

  static const List<String> dummyData = ["hey there i am ", "hey there i am "];
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerScreen(selectedVal: 1),
      endDrawerEnableOpenDragGesture: true,
      key: drawerKey,
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "searchScreen");
                },
                child: topBarHomeScreen(context, drawerKey)),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 116,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 50,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 100,
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemBuilder: (context, index) => notesViewItem("dummy")))

            // const SizedBox(height: 15),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: cardColor,
          onPressed: () {
            Navigator.pushNamed(context, "editNotesScreen");
          },
          child: const Icon(Icons.create, color: Colors.white)),
    );
  }
}

Container notesViewItem(data) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: white.withOpacity(0.5))),
    child: Text(
      data,
      style: TextStyle(color: white),
    ),
  );
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
