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
        child: SingleChildScrollView(
          child: Column(
            children: [
              topBarHomeScreen(context, drawerKey),
              const SizedBox(height: 20),
              notesViewHome(),
            ],
          ),
        ),
      ),
    );
  }
}

Container notesViewHome() {
  return Container(child: Text("data")
      //
      //     GridView.custom(
      //   gridDelegate: SliverQuiltedGridDelegate(
      //     crossAxisCount: 4,
      //     mainAxisSpacing: 4,
      //     crossAxisSpacing: 4,
      //     repeatPattern: QuiltedGridRepeatPattern.inverted,
      //     pattern: [
      //       QuiltedGridTile(2, 2),
      //       QuiltedGridTile(1, 1),
      //       QuiltedGridTile(1, 1),
      //       QuiltedGridTile(1, 2),
      //     ],
      //   ),
      //   childrenDelegate: SliverChildBuilderDelegate(
      //     (context, index) => GridTile(index: index),
      //   ),
      // )
      //

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
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
