import 'package:flutter/material.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage('asset/study.gif')),
        const SizedBox(height: 30),
        const Text(
          '공부 페이지',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'supermagic',
          ),
        ),
      ].toList(),
    );
  }
}
