import 'package:confwebsite2021/utils/responsive_layout.dart';
import 'package:confwebsite2021/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFF8FBFF),
            Color(0xFFFCFDFD),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              NavBar(),
              Body(),
            ],
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeBodyChild(),
      smallScreen: SmallBodyChild(),
    );
  }
}

class LargeBodyChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 2000,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: FractionallySizedBox(
            widthFactor: .8,
            child: FractionallySizedBox(
              alignment: Alignment.center,
              widthFactor: .6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    '/flutterkaigi-center_logo.png',
                    width: 398,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: '@ONLINE / 2021 Winter',
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text(
            '©︎ 2021 Flutter Japan User Group',
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

class SmallBodyChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  '/flutterkaigi-center_logo.png',
                  width: 284,
                ),
                RichText(
                  text: const TextSpan(
                    text: '@ONLINE / 2021 Winter',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text(
            '©︎ 2021 Flutter Japan User Group',
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ]
    );
  }
}
