import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage('asset/homepage/hello.gif')),
        const SizedBox(height: 30),
        const Text(
          '프로필 페이지',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'supermagic',
          ),
        ),
        const Image(image: AssetImage('asset/homepage/hello.gif')),
        const SizedBox(height: 30),
        const Text(
          '프로필 페이지',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'supermagic',
          ),
        ),
        const Image(image: AssetImage('asset/homepage/hello.gif')),
        const SizedBox(height: 30),
        const Text(
          '프로필 페이지',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'supermagic',
          ),
        ),
        const Image(image: AssetImage('asset/homepage/hello.gif')),
        const SizedBox(height: 30),
        const Text(
          '프로필 페이지',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'supermagic',
          ),
        ),
        const Image(image: AssetImage('asset/homepage/hello.gif')),
        const SizedBox(height: 30),
        const Text(
          '프로필 페이지',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'supermagic',
          ),
        ),
        const Image(image: AssetImage('asset/homepage/hello.gif')),
        const SizedBox(height: 30),
        const Text(
          '프로필 페이지',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'supermagic',
          ),
        ),
        const Image(image: AssetImage('asset/homepage/hello.gif')),
        const SizedBox(height: 30),
        const Text(
          '프로필 페이지',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'supermagic',
          ),
        ),
      ].toList(),
    );
  }
}
