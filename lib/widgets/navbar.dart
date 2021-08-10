import 'package:confwebsite2021/utils/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkModel {
  LinkModel(this.name, this.url);

  final String name;
  final String url;
}

class NavBar extends StatelessWidget {
  final List<Map<String, dynamic>> navLinks = [
    {'name': 'Home', 'url': '/', 'twitterIcon': false},
    {'name': 'Event', 'url': 'https://flutter-jp.connpass.com/', 'twitterIcon': false},
    {
      'name': 'Tweet with #FlutterKaigi',
      'url': 'https://twitter.com/intent/tweet?hashtags=FlutterKaigi',
      'twitterIcon': true,
    },
  ];

  List<Widget> navItem() {
    return navLinks.map((link) {
      if (link['twitterIcon'] == false)
        return Padding(
          padding: const EdgeInsets.only(left: 18),
          child: ElevatedButton(
            onPressed: () async {
              await launch(link['url']!);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
            ),
            child: Text(
              link['name']!,
              style: const TextStyle(fontFamily: 'Montserrat-Bold'),
            ),
          ),
        );
      else
        return Padding(
          padding: const EdgeInsets.only(left: 18),
          child: FloatingActionButton.extended(
            tooltip: '#FlutterKaigi でツイートしよう！',
            icon: SvgPicture.asset(
              '/twitter_white.svg',
              width: 30,
            ),
            label: const Text('ツイート'),
            onPressed: () async {
              await launch('https://twitter.com/search?q=%23FlutterKaigi');
            },
          ),
        );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 38),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  '/flutterkaigi-navbar_logo.svg',
                  width: 240,
                ),
              ],
            ),
            if (!ResponsiveLayout.isSmallScreen(context))
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[...navItem()])
          ],
        ),
      ),
    );
  }
}
