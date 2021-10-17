import 'dart:math' as math;

import 'package:confwebsite2021/gen/assets.gen.dart';
import 'package:confwebsite2021/responsive_layout_builder.dart';
import 'package:confwebsite2021/widgets/cfs_button.dart';
import 'package:confwebsite2021/widgets/connpass_button.dart';
import 'package:confwebsite2021/widgets/footer.dart';
import 'package:confwebsite2021/widgets/social.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

enum MenuItem { event, tweet }

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

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
        body: Stack(
          children: [
            const Body(),
            _Canvas(size: MediaQuery.of(context).size),
          ],
        ),
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
  const Body({Key? key}) : super(key: key);

  TextStyle get titleTextStyle => const TextStyle(fontSize: 64);

  TextStyle get subtitleTextStyle => const TextStyle(fontSize: 36);

  int get logoWidth => 320;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ResponsiveLayoutBuilder(builder: (context, layout, width) {
      final sizeFactor = (layout == ResponsiveLayout.slim) ? 0.6 : 1.0;

      return CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
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
                          style:
                              titleTextStyle.apply(fontSizeFactor: sizeFactor),
                        ),
                      ),
                      Gap(32 * sizeFactor),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          '@ONLINE / November 29-30, 2021',
                          style: subtitleTextStyle.apply(
                              fontSizeFactor: sizeFactor),
                        ),
                      ),
                      const Gap(32),
                      const ConnpassButton(),
                      const Gap(16),
                      const CfsButton(),
                      const Gap(16),
                      FittedBox(
                        child: Text(
                          appLocalizations.endedSubmitProposal,
                          style: subtitleTextStyle.apply(fontSizeFactor: 0.4),
                        ),
                      ),
                      const Gap(32),
                      const Social(),
                    ],
                  ),
                ),
                const Spacer(),
                const Footer(),
              ],
            ),
          )
        ],
      );
    });
  }
}

final _random = math.Random();

class Logo {
  Offset position = Offset.zero;
  double angle = 0.0;

  final double rotateSpeed = _random.nextDouble() * math.pi * 0.01;
  final double speed = _random.nextDouble() * 1 + 0.5;
  final double size = _random.nextDouble() * 60 + 30;

  Logo(this.position);
}

final logos = ValueNotifier<List<Logo>>([]);

class _Canvas extends StatefulWidget {
  const _Canvas({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  _CanvasState createState() => _CanvasState();
}

class _CanvasState extends State<_Canvas> with SingleTickerProviderStateMixin {
  late final _controller =
      AnimationController(vsync: this, duration: const Duration(days: 1))
        ..addListener(
          () {
            final update = [...logos.value];
            for (final logo in update) {
              logo.position += Offset(0, -logo.speed);
              logo.angle += logo.rotateSpeed;
              if (logo.position.dy < widget.size.height / 3) {
                final index = logos.value.indexOf(logo);
                update[index] = generateLogo();
              }
            }
            logos.value = update;
          },
        );

  @override
  void initState() {
    logos.value = List.generate(10, (index) => generateLogo());
    _controller.forward();
    super.initState();
  }

  Logo generateLogo() => Logo(Offset(
        widget.size.width * _random.nextDouble(),
        widget.size.height,
      ));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: logos,
      builder: (context, List<Logo> value, _) => _Background(logos: value),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _Background extends StatelessWidget {
  const _Background({Key? key, required this.logos}) : super(key: key);

  final List<Logo> logos;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        for (final logo in logos)
          Positioned(
            top: logo.position.dy,
            left: logo.position.dx,
            child: Opacity(
              opacity: (logo.position.dy - height / 3) / height / 3,
              child: Transform.rotate(
                angle: logo.angle,
                child: FlutterLogo(
                  size: logo.size,
                ),
              ),
            ),
          )
      ],
    );
  }
}
