import 'package:confwebsite2021/utils/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class _LinkModel {
  _LinkModel({
    required this.name,
    required this.url,
    this.linkNewTab,
    this.icon,
    this.tooltip,
  });

  final String name;
  final String url;
  final bool? linkNewTab;
  final String? tooltip;
  final Widget? icon;
}

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final navLinks = [
      _LinkModel(name: appLocalizations.home, url: '/'),
      _LinkModel(
        name: appLocalizations.event,
        tooltip: 'https://flutter-jp.connpass.com/',
        url: 'https://flutter-jp.connpass.com/',
        linkNewTab: true,
      ),
      _LinkModel(
        name: appLocalizations.tweet,
        tooltip: appLocalizations.letsTweet,
        url: 'https://twitter.com/intent/tweet?hashtags=FlutterKaigi',
        icon: SvgPicture.asset(
          '/twitter_white.svg',
          width: 20,
        ),
      ),
    ];

    List<Widget> navItem() {
      return [
        for (final link in navLinks) ...[
          const SizedBox(width: 18),
          if (link.icon == null)
            if (link.tooltip != null)
              Tooltip(
                  message: link.tooltip ?? '',
                  child: ElevatedButton(
                    onPressed: () async {
                      await launch(
                        link.url,
                        webOnlyWindowName:
                            link.linkNewTab == true ? '_blank' : '_self',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                    ),
                    child: Text(
                      link.name,
                      style: const TextStyle(fontFamily: 'Montserrat-Bold'),
                    ),
                  ))
            else
              ElevatedButton(
                onPressed: () async {
                  await launch(
                    link.url,
                    webOnlyWindowName:
                        link.linkNewTab == true ? '_blank' : '_self',
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                child: Text(
                  link.name,
                  style: const TextStyle(fontFamily: 'Montserrat-Bold'),
                ),
              )
          else
            FloatingActionButton.extended(
              tooltip: link.tooltip,
              icon: link.icon,
              label: Text(link.name),
              onPressed: () async {
                await launch(link.url);
              },
            ),
        ]
      ];
    }

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
