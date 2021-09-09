import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkModel {
  LinkModel(this.name, this.url);

  final String name;
  final String url;
}

class Social extends StatelessWidget {
  const Social({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socialLinks = <Map<String, String>>[
      {
        'name': 'twitter_logo',
        'url': 'https://twitter.com/FlutterKaigi',
      },
      {
        'name': 'github_logo',
        'url': 'https://github.com/FlutterKaigi',
      },
      {
        'name': 'discord_logo',
        'url': 'https://discord.gg/Nr7H8JTJSF',
      },
    ];

    List<Widget> socialItem() {
      return socialLinks.map((link) {
        return IconButton(
          tooltip: link['url'],
          icon: SvgPicture.asset(
            '/${link['name']}.svg',
            width: 60,
          ),
          onPressed: () async {
            await launch(link['url']!);
          },
          mouseCursor: SystemMouseCursors.click,
        );
      }).toList();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[...socialItem()],
    );
  }
}
