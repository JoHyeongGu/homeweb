// ignore_for_file: must_be_immutable, void_checks

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homeweb/profile_page.dart';
import 'package:homeweb/study_page.dart';
import 'package:homeweb/title_page.dart';
import 'package:homeweb/works_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Map deviceSize = {
      'width': MediaQuery.of(context).size.width,
      'height': MediaQuery.of(context).size.height,
    };
    bool smallWeb = deviceSize['width'] < 1000 || deviceSize['height'] < 500;
    return MaterialApp(
      title: '구페이지',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: MyHomePage(deviceSize: deviceSize, smallWeb: smallWeb),
    );
  }
}

class MyHomePage extends StatefulWidget {
  Map deviceSize;
  bool smallWeb;
  MyHomePage({super.key, required this.deviceSize, required this.smallWeb});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool detailVisible = false;
  String? detailContent;

  void enterDetailPage({String? title}) {
    setState(() {
      if (title == null){
        Future.delayed(const Duration(milliseconds: 200), () {
          detailContent = title;
        });
      } else {
        detailContent = title;
      }
      detailVisible = !(title == null);
    });
  }

  Widget detailPage(String? detailTitle) {
    if(!detailVisible && detailTitle == null){
      return SizedBox();
    }
    List<double> paddingSize = [300, widget.smallWeb ? 0 : 50];
    Widget content = detailTitle != null ? {
      'profile': const ProfilePage(),
      'works': const WorksPage(),
      'study': const StudyPage(),
    }[detailTitle]! : const SizedBox();
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 200),
        left: widget.smallWeb ? 0 : paddingSize[0] / 2 / 2,
        bottom: detailVisible
            ? paddingSize[1] / 2
            : -(widget.deviceSize['height'] - paddingSize[1]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.smallWeb
                ? Container()
                : SideMenu(
                    width: paddingSize[0] / 2 / 2,
                    selectedTitle: detailTitle,
                    enterDetailPage: enterDetailPage,
                  ),
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color.fromRGBO(255, 254, 233, 1.0),
              height: widget.deviceSize['height'] - paddingSize[1],
              width: widget.smallWeb
                  ? widget.deviceSize['width']
                  : widget.deviceSize['width'] - paddingSize[0],
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: content,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        TitlePage(
          enterDetailPage: enterDetailPage,
          smallWeb: widget.smallWeb,
        ),
        detailPage(detailContent),
      ],
    ));
  }
}

class SideMenu extends StatefulWidget {
  double width;
  Function enterDetailPage;
  String? selectedTitle;
  SideMenu({
    Key? key,
    required this.width,
    required this.enterDetailPage,
    this.selectedTitle,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Map<String, String> itemList = {
    'profile': '프로필',
    'works': '작업실',
    'study': '공부',
  };

  Widget item(MapEntry data) {
    bool selected = widget.selectedTitle == data.key;
    return Padding(
      padding: EdgeInsets.only(bottom: selected ? 3 : 1),
      child: GestureDetector(
        onTap: () {
          widget.enterDetailPage(title: data.key);
          setState(() {});
        },
        child: Container(
          color: Color.fromRGBO(255, 255, 79, selected ? 0.9 : 0.7),
          width: widget.width,
          height: selected ? 35 : 30,
          child: Center(
              child: Text(
            data.value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'supermagic',
            ),
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: itemList.entries.map((entry) => item(entry)).toList(),
      ),
    );
  }
}
