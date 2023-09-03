// ignore_for_file: must_be_immutable, void_checks

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '구페이지',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String backgroundImg = "asset/earth.gif";

  void changingBackgroundImage(String? image) {
    if (image != null) {
      backgroundImg = image;
    } else {
      backgroundImg = "asset/earth.gif";
    }
    setState(() {});
  }

  Widget menuList(List menu) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: menu
          .map((e) => MenuButton(
                data: e,
                changingBackgroundImage: changingBackgroundImage,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Image.asset(
              backgroundImg,
              key: ValueKey<String>(backgroundImg),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(color: const Color.fromRGBO(1, 1, 1, 0.5)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                menuText("나만의 구, 페이지", title: true),
                menuList([
                  {'title': 'profile', 'image': 'asset/hello.gif'},
                  {'title': 'works', 'image': 'asset/work.gif'},
                  {'title': 'study', 'image': 'asset/study.gif'},
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget menuText(String text, {bool title = false, bool focus = false}) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.white,
        fontSize: title
            ? 60
            : focus
                ? 23
                : 20,
        fontWeight: title ? FontWeight.bold : FontWeight.normal,
        fontFamily: 'supermagic'),
  );
}

class MenuButton extends StatefulWidget {
  Map data;
  Function changingBackgroundImage;
  MenuButton(
      {super.key, required this.data, required this.changingBackgroundImage});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _focus = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      child: TextButton(
        onPressed: () {
          print(widget.data['title']);
        },
        onHover: (state) {
          setState(() {
            _focus = state;
          });
          if (state) {
            widget.changingBackgroundImage(widget.data['image']);
          } else {
            widget.changingBackgroundImage(null);
          }
        },
        onFocusChange: (state) {
          setState(() {
            _focus = state;
          });
          if (state) {
            widget.changingBackgroundImage(widget.data['image']);
          } else {
            widget.changingBackgroundImage(null);
          }
        },
        child: menuText(widget.data['title'], focus: _focus),
      ),
    );
  }
}
