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
    return SizedBox(
      height: 600,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: .6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: const TextSpan(
                      text: 'FlutterKaigi 2021',
                      style: TextStyle(
                          fontSize: 60,
                          color: Colors.black87,
                      ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 20),
                  child: Text('Tech Conference for Flutter in Japan'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SmallBodyChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: const TextSpan(
                text: 'FlutterKaigi 2021',
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.black87,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 20),
              child: Text('Tech Conference for Flutter in Japan'),
            ),
          ],
        ),
      ),
    );
  }
}
