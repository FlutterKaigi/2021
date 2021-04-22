import 'package:confwebsite2021/pages/index.dart';
import 'package:confwebsite2021/router/index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterKaigi 2021',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      onGenerateRoute: buildRouters,
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;

  int _screen = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _screen,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _screen = index;
            });
          },
          children: [
            TopPage(),
          ]),
    );
  }
}
