// ignore_for_file: must_be_immutable, void_checks

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
  bool detailVisible = false;
  String? detailContent;

  void enterDetailPage({String? title}) {
    setState(() {
      detailVisible = !(title == null);
      detailContent = title;
    });
  }

  Widget detailPage(String? detailTitle) {
    List<double> deviceSize = [MediaQuery.of(context).size.width, MediaQuery.of(context).size.height];
    List<double> paddingSize = [300, 50];
    const Map<String, Widget> content = {
      'profile': ProfilePage(),
      'works': WorksPage(),
      'study': StudyPage(),
    };
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 200),
        left: paddingSize[0] / 2,
        bottom: detailVisible ? 0 : -(deviceSize[1] - paddingSize[1]),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: const Color.fromRGBO(255, 254, 233, 1.0),
          height: deviceSize[1] - paddingSize[1],
          width: deviceSize[0] - paddingSize[0],
          child: content[detailTitle],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        TitlePage(
          enterDetailPage: enterDetailPage,
        ),
        detailPage(detailContent),
      ],
    ));
  }
}
