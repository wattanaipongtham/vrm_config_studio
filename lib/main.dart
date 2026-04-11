import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:flutter_application_1/menus.dart';
import 'package:flutter_application_1/leftSide.dart';

const borderColor = Color(0xFF805306);

void main() {
  runApp(MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(800, 480);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "VRM Config Studio";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late int leftFlex;
  late int rightFlex;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 800)
            {
              leftFlex = 1;
              rightFlex = 8;
            }else
            {
              leftFlex = 2;
              rightFlex = 6;
            }
            return WindowBorder(
              color: borderColor,
              width: 1,
              child: Column(
                children:[
                  SizedBox(
                    height: 31,
                    child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TopLeftBar()
                          ),
                          Expanded(
                            flex: 1,
                            child: TopRightBar()
                          ),
                        ],
                      ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: leftFlex,
                          child:LeftSide(),
                        ),
                        Expanded(
                          flex: rightFlex,
                          child:RightSide(),
                        )
                      ],
                    )
                  )
                ],
              )
            );
          },
        ),
      )
    );
  }
}

const sidebarColor = Color.fromARGB(255, 24, 24, 27);
const mainAreaColor = Color.fromARGB(255, 9, 9, 11);
const topbarColor = Color.fromARGB(255, 255, 255, 255);

class TopLeftBar extends StatelessWidget {
TopLeftBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
          color: topbarColor,
          child: Column(
            children: [
              WindowTitleBarBox(
                child: Row(
                  children: [
                    MyCascadingMenu(message: "Hello world"),
                    RunMenu(message: "Hello world2"),
                    Expanded(child: MoveWindow()),
                  ]
                ),
              )
            ],
          )
        )
      );
  }
}

class TopRightBar extends StatelessWidget {
TopRightBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: topbarColor,
        child: Column(children: [
          WindowTitleBarBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Expanded(child: MoveWindow()),const WindowButtons()],
            ),
          )
        ]),
      );
  }
}

class LeftSide extends StatelessWidget {
  LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: sidebarColor,
      child: SizedBox(
        child: MainMenuLists(),
      ),
    );
  }
}

class RightSide extends StatelessWidget {
   RightSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainAreaColor,
      child:  SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text("World!!"),
          ],
        ),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}