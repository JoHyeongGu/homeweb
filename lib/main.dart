import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:homeweb/3d_web/3d_page_main.dart';
import 'package:homeweb/homepage/main.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  return runApp(MyApp());
}

List<Map> pageList = [
  {
    'path': '/homepage',
    'widget': const MyHomePage(),
    'title': '홈페이지 로비',
    'description': '다양한 메뉴가 있는 홈페이지의 로비를 만들어보자',
  },
  {
    'path': '/3d-web',
    'widget': const ThreeDPage(),
    'title': '3D 위젯 구현',
    'description': '토스의 3D 위젯들을 공부해보자',
  },
];

initRouter() {
  FluroRouter router = FluroRouter();
  for (Map page in pageList) {
    router.define(
      page['path'],
      handler: Handler(
        handlerFunc: (context, params) {
          return page['widget'];
        },
      ),
      transitionType: TransitionType.cupertinoFullScreenDialog,
    );
  }
  return router;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  FluroRouter router = initRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '구페이지: 위젯 연구소',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      onGenerateRoute: router.generator,
      routes: {
        '/': (context) => TitlePage(router),
      },
    );
  }
}

class TitlePage extends StatefulWidget {
  TitlePage(this.router, {super.key});
  FluroRouter router;

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  PageController pageController = PageController();
  List<Widget> pages = [const TitleWidget()];

  @override
  void initState() {
    for (Map page in pageList) {
      pages.add(
        OtherPage(
            router: widget.router,
            content: page['widget'],
            title: page['title'],
            description: page['description'],
            path: page['path']),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlueAccent,
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 15,
              left: 20,
              child: IconButton(
                onPressed: () {
                  if (pageController.hasClients) {
                    if (pageController.page == 0) {
                      pageController.animateToPage(
                        duration: const Duration(milliseconds: 300),
                        pages.length,
                        curve: Curves.linear,
                      );
                    } else {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.linear);
                    }
                  }
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width / 25,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
                child: PageView(
                  controller: pageController,
                  children: pages,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 15,
              right: 20,
              child: IconButton(
                onPressed: () {
                  if (pageController.hasClients) {
                    if (pageController.page == pages.length - 1) {
                      pageController.animateToPage(
                        duration: const Duration(milliseconds: 300),
                        0,
                        curve: Curves.linear,
                      );
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.linear,
                      );
                    }
                  }
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width / 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Flutter 연구소',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 70),
          Text(
            '해당 도메인은 flutter의 기능을 연구 하기 위한 연구소입니다.',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 80,
              color: Colors.white,
            ),
          )
        ].map((e) => Flexible(child: e)).toList(),
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  OtherPage(
      {super.key,
      required this.router,
      required this.path,
      required this.content,
      required this.title,
      required this.description});
  FluroRouter router;
  String path;
  Widget content;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        router.navigateTo(context, path);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.height / 6,
            child: Stack(
              children: [
                Transform.scale(
                  scale: 1,
                  child: content,
                ),
                Container(color: Colors.white.withOpacity(0.3)),
                Image.asset('asset/minecraft_glass.png'),
              ],
            ),
          ),
          if (MediaQuery.of(context).size.width > 700)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 40,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 70),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 80,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
