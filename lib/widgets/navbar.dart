import 'package:confwebsite2021/utils/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkModel {
  LinkModel(this.name, this.url);

  final String name;
  final String url;
}

class NavBar extends StatelessWidget {
  final List<Map<String, String>> navLinks = [
    {'name': 'Home', 'url': '/'},
    {'name': 'Event', 'url': 'https://flutter-jp.connpass.com/'},
  ];

  List<Widget> navItem() {
    return navLinks.map((link) {
      return Padding(
        padding: const EdgeInsets.only(left: 18),
        child: ElevatedButton(
          onPressed: () async {
            await launch(link['url']);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
          child: Text(
            link['name'],
            style: const TextStyle(fontFamily: 'Montserrat-Bold'),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 38),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                      'FlutterKaigi 2021',
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                      ),
                  ),
                ],
              ),
              if (!ResponsiveLayout.isSmallScreen(context))
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[...navItem()]
                )
              else
                Image.network('assets/flutter.png', width: 26, height: 26)
            ],
          ),
        ),
    );
  }
}
