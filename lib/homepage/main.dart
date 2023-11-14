import 'package:flutter/material.dart';

import 'profile_page.dart';
import 'study_page.dart';
import 'title_page.dart';
import 'works_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool detailVisible = false;

  String? detailContent;
  List<Map> contentList = [
    {'id': 'profile', 'name': '프로필', 'widget': const ProfilePage()},
    {'id': 'works', 'name': '작업실', 'widget': const WorksPage()},
    {'id': 'study', 'name': '공부', 'widget': const StudyPage()},
    {'id': 'test', 'name': '테스트', 'widget': const StudyPage()},
  ];

  void enterDetailPage({String? title}) {
    setState(() {
      if (title == null) {
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
    if (!detailVisible && detailTitle == null) {
      return SizedBox();
    }
    List<double> paddingSize = [300, MediaQuery.of(context).size.width < 1000 || MediaQuery.of(context).size.height < 500 ? 0 : 50];
    Widget content = detailTitle != null
        ? contentList.where((c) => c['id'] == detailTitle).toList()[0]['widget']
        : const SizedBox();
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 200),
        left: MediaQuery.of(context).size.width < 1000 || MediaQuery.of(context).size.height < 500 ? 0 : paddingSize[0] / 2 / 2,
        bottom: detailVisible
            ? paddingSize[1] / 2
            : -(MediaQuery.of(context).size.height - paddingSize[1]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaQuery.of(context).size.width < 1000 || MediaQuery.of(context).size.height < 500
                ? Container()
                : SideMenu(
                    width: paddingSize[0] / 2 / 2,
                    contentList: contentList,
                    selectedTitle: detailTitle,
                    enterDetailPage: enterDetailPage,
                  ),
            Container(
              padding: const EdgeInsets.all(40),
              color: const Color.fromRGBO(255, 254, 233, 1.0),
              height: MediaQuery.of(context).size.height - paddingSize[1],
              width: MediaQuery.of(context).size.width < 1000 || MediaQuery.of(context).size.height < 500
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width - paddingSize[0],
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
          smallWeb: MediaQuery.of(context).size.width < 1000 || MediaQuery.of(context).size.height < 500,
          menuList: contentList,
        ),
        detailPage(detailContent),
      ],
    ));
  }
}

class SideMenu extends StatefulWidget {
  double width;
  Function enterDetailPage;
  List<Map> contentList;
  String? selectedTitle;
  SideMenu({
    Key? key,
    required this.width,
    required this.enterDetailPage,
    required this.contentList,
    this.selectedTitle,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Widget item(Map data) {
    bool selected = widget.selectedTitle == data['id'];
    return Padding(
      padding: EdgeInsets.only(bottom: selected ? 3 : 1),
      child: GestureDetector(
        onTap: () {
          widget.enterDetailPage(title: data['id']);
          setState(() {});
        },
        child: Container(
          color: Color.fromRGBO(255, 255, 79, selected ? 0.9 : 0.7),
          width: widget.width,
          height: selected ? 35 : 30,
          child: Center(
              child: Text(
            data['name'],
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
        children: widget.contentList.map((entry) => item(entry)).toList(),
      ),
    );
  }
}
