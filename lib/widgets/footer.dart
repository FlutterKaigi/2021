import 'package:confwebsite2021/utils/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LinkModel {
  LinkModel(this.name, this.url);

  final String name;
  final String url;
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final footerLinks = <Map<String, String>>[
      {
        'name': '行動規範',
        'url': 'https://flutterkaigi.github.io/flutterkaigi/Code-of-Conduct.ja.html',
      },
      {
        'name': 'プライバシーポリシー',
        'url': 'https://flutterkaigi.github.io/flutterkaigi/Privacy-Policy.ja.html',
      },
      {
        'name': 'お問い合わせ',
        'url': 'https://docs.google.com/forms/d/e/1FAIpQLSemYPFEWpP8594MWI4k3Nz45RJzMS7pz1ufwtnX4t3V7z2TOw/viewform',
      },
    ];

    List<Widget> footerItem() {
      return footerLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: ElevatedButton(
            onPressed: () async {
              await launch(link['url']);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              primary: Colors.blueAccent,
              onPrimary: Colors.black,
            ),
            child: Text(
              link['name'],
              style: const TextStyle(
                color: Colors.white70,
                fontFamily: 'Montserrat-Bold',
              ),
            ),
          ),
        );
      }).toList();
    }

    return Container(
      padding: const EdgeInsets.all(18),
      width: 500,
      color: const Color(0xFFF8FBFF),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          if (!ResponsiveLayout.isSmallScreen(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[...footerItem()]
            )
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[...footerItem()]
            ),
          const Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              '©︎ 2021 Flutter Japan User Group',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
