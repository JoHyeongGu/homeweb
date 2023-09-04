// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

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

class TitlePage extends StatefulWidget {
  Function enterDetailPage;
  String? detailContent;
  TitlePage({Key? key, required this.enterDetailPage, this.detailContent})
      : super(key: key);

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
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
              enterDetailPage: widget.enterDetailPage))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        GestureDetector(
          onTap: () {
            widget.enterDetailPage();
          },
          child: Container(color: const Color.fromRGBO(1, 1, 1, 0.5)),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menuText("인생의 구, 페이지", title: true),
              const SizedBox(height: 30),
              menuList([
                {'title': 'profile', 'image': 'asset/hello.gif'},
                {'title': 'works', 'image': 'asset/work.gif'},
                {'title': 'study', 'image': 'asset/study.gif'},
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

class MenuButton extends StatefulWidget {
  Map data;
  Function changingBackgroundImage;
  Function enterDetailPage;
  MenuButton(
      {super.key,
      required this.data,
      required this.changingBackgroundImage,
      required this.enterDetailPage});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _focus = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          widget.changingBackgroundImage(widget.data['image']);
        },
        onTapCancel: () {
          widget.changingBackgroundImage(null);
        },
        child: TextButton(
          onPressed: () {
            widget.enterDetailPage(title: widget.data['title']);
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
          child: menuText(widget.data['title'], focus: _focus),
        ),
      ),
    );
  }
}
