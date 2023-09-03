import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '형구의 Home페이지',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
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
  Color? background;

  @override
  void initState() {
    background = Colors.green;
    print('color');
    super.initState();
  }

  Widget _text(String text, double size) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: size),
    );
  }

  Widget menuList(List menu) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: menu
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: TextButton(
                  onPressed: () {
                    print(e['title']);
                  },
                  onHover: (state){
                    setState(() {
                      if (state){
                        background = e['color'];
                      } else{
                        background = Colors.green;
                      }
                    });
                  },
                  child: _text(e['title'], 15),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _text('Title Page', 60),
              const SizedBox(height: 10),
              menuList([
                {'title': 'menu1', 'color': Colors.redAccent},
                {'title': 'menu2', 'color': Colors.blue},
                {'title': 'menu3', 'color': Colors.yellow},
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
