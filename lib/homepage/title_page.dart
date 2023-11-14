// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TitlePage extends StatefulWidget {
  Function enterDetailPage;
  List<Map> menuList;
  String? detailContent;
  bool smallWeb;
  TitlePage(
      {Key? key,
      required this.enterDetailPage,
      required this.menuList,
      this.detailContent,
      required this.smallWeb})
      : super(key: key);

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  String backgroundImg = "asset/homepage/earth.gif";

  void changingBackgroundImage(String? image) {
    if (image != null) {
      backgroundImg = image;
    } else {
      backgroundImg = "asset/homepage/earth.gif";
    }
    setState(() {});
  }

  Widget menuList(List menu) {
    List<Widget> items = menu
        .map((e) => Flexible(
              child: MenuButton(
                data: e,
                changingBackgroundImage: changingBackgroundImage,
                enterDetailPage: widget.enterDetailPage,
                smallWeb: widget.smallWeb,
              ),
            ))
        .toList();
    return widget.smallWeb
        ? SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: menuText("인생의 구, 페이지", title: true),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: menuList(
                  [
                    {'title': 'profile', 'image': 'asset/homepage/hello.gif'},
                    {'title': 'works', 'image': 'asset/homepage/work.gif'},
                    {'title': 'study', 'image': 'asset/homepage/study.gif'},
                  ],
                ),
              ),
            ].map((e) => Flexible(child: e)).toList(),
          ),
        ),
      ],
    );
  }
}

Widget menuText(String text, {bool title = false, bool focus = false}) {
  return AutoSizeText(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: title
          ? 80
          : focus
              ? 23
              : 20,
      fontWeight: title ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'supermagic',
    ),
    maxLines: 1,
  );
}

class MenuButton extends StatefulWidget {
  Map data;
  bool smallWeb;
  Function changingBackgroundImage;
  Function enterDetailPage;
  MenuButton({
    super.key,
    required this.data,
    required this.changingBackgroundImage,
    required this.enterDetailPage,
    required this.smallWeb,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _focus = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      height: widget.smallWeb ? 500 : 30,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          setState(() {
            _focus = true;
          });
          widget.changingBackgroundImage(widget.data['image']);
        },
        onTapCancel: () {
          setState(() {
            _focus = false;
          });
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
