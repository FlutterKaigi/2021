import 'package:confwebsite2021/gen/assets.gen.dart';
import 'package:confwebsite2021/responsive_layout_builder.dart';
import 'package:confwebsite2021/widgets/footer.dart';
import 'package:confwebsite2021/widgets/social.dart';
import 'package:confwebsite2021/widgets/cfs_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

enum MenuItem { event, tweet }

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(builder: (context, layout, width) {
      return Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            Assets.flutterkaigiNavbarLogo,
            // height: kToolbarHeight,
            width: 240,
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: buildActions(context, layout, width),
        ),
        body: Body(),
      );
    });
  }

  List<Widget> buildActions(
      BuildContext context, ResponsiveLayout layout, double width) {
    if (layout == ResponsiveLayout.slim) {
      return buildPopupMenuButton(context);
    } else {
      return buildActionButtons(context);
    }
  }

  List<Widget> buildPopupMenuButton(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return [
      PopupMenuButton<MenuItem>(
        icon: const Icon(Icons.menu, color: Colors.black),
        onSelected: (MenuItem result) async {
          String urlString;
          switch (result) {
            case MenuItem.event:
              urlString = 'https://flutter-jp.connpass.com/';
              break;
            case MenuItem.tweet:
              urlString =
                  'https://twitter.com/intent/tweet?hashtags=FlutterKaigi';
              break;
          }
          await launch(
            urlString,
            webOnlyWindowName: '_blank',
          );
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
          PopupMenuItem<MenuItem>(
            value: MenuItem.event,
            child: Text(appLocalizations.event),
          ),
          PopupMenuItem<MenuItem>(
            value: MenuItem.tweet,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blue,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.twitterWhite, width: 20),
                  const Gap(8),
                  Text(
                    appLocalizations.tweet,
                    style: Theme.of(context).textTheme.button?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    ];
  }

  List<Widget> buildActionButtons(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return [
      Container(
        margin: const EdgeInsets.all(8),
        child: Tooltip(
          message: 'https://flutter-jp.connpass.com/',
          child: TextButton(
            onPressed: () async {
              await launch(
                'https://flutter-jp.connpass.com/',
                webOnlyWindowName: '_blank',
              );
            },
            child: Text(appLocalizations.event),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(8),
        child: Tooltip(
          message: appLocalizations.letsTweet,
          child: ElevatedButton.icon(
            onPressed: () async {
              await launch(
                'https://twitter.com/intent/tweet?hashtags=FlutterKaigi',
                webOnlyWindowName: '_blank',
              );
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
            icon: SvgPicture.asset(Assets.twitterWhite, width: 20),
            label: Text(appLocalizations.tweet),
          ),
        ),
      ),
    ];
  }
}

class Body extends StatelessWidget {
  final titleTextStyle = const TextStyle(fontSize: 64);
  final subtitleTextStyle = const TextStyle(fontSize: 36);
  final logoWidth = 320;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveLayoutBuilder(builder: (context, layout, width) {
        final sizeFactor = (layout == ResponsiveLayout.slim) ? 0.6 : 1.0;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  SvgPicture.asset(
                    Assets.flutterkaigiLogo,
                    width: logoWidth * sizeFactor,
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'FlutterKaigi',
                      style: titleTextStyle.apply(fontSizeFactor: sizeFactor),
                    ),
                  ),
                  Gap(32 * sizeFactor),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      '@ONLINE / November 29-30, 2021',
                      style:
                          subtitleTextStyle.apply(fontSizeFactor: sizeFactor),
                    ),
                  ),
                  const Gap(32),
                  CfsButton(),
                  const Gap(32),
                  Social(),
                ],
              ),
            ),
            Footer(),
          ],
        );
      }),
    );
  }
}
