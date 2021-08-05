import 'package:confwebsite2021/utils/responsive_layout.dart';
import 'package:confwebsite2021/widgets/navbar.dart';
import 'package:confwebsite2021/widgets/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                  SvgPicture.asset(
                    '/flutterkaigi_log.svg',
                    width: 320,
                  ),
                  const Text(
                    'FlutterKaigi',
                    style: TextStyle(
                      fontSize: 64,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 32),
                  RichText(
                    text: const TextSpan(
                      text: '@ONLINE / Winter 2021',
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
        Footer(),
      ],
    );
  }
}

class SmallBodyChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                '/flutterkaigi_log.svg',
                width: 284,
              ),
              const Text(
                'FlutterKaigi',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black87,
                ),
              ),
              RichText(
                text: const TextSpan(
                  text: '@ONLINE / Winter 2021',
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
      Footer(),
    ]);
  }
}
