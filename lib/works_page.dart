import 'package:flutter/material.dart';

class WorksPage extends StatefulWidget {
  const WorksPage({Key? key}) : super(key: key);

  @override
  State<WorksPage> createState() => _WorksPageState();
}

class _WorksPageState extends State<WorksPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage('asset/work.gif')),
        const SizedBox(height: 30),
        const Text(
          '작업실 페이지',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'supermagic',
          ),
        ),
      ].map((e) => Flexible(child: e)).toList(),
    );
  }
}
