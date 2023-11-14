import 'package:flutter/material.dart';

class ThreeDPage extends StatefulWidget {
  const ThreeDPage({super.key});

  @override
  State<ThreeDPage> createState() => _ThreeDPageState();
}

class _ThreeDPageState extends State<ThreeDPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(252, 252, 252, 1.0),
      child: Center(child: Image.asset('asset/3d_web/toss_logo.gif')),
    );
  }
}
