import 'dart:math' as math;

import 'package:confwebsite2021/gen/assets.gen.dart';
import 'package:confwebsite2021/responsive_layout_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sprintf/sprintf.dart';

class TeaserPage extends StatelessWidget {
  const TeaserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(builder: (context, layout, width) {
      return Scaffold(
        body: Stack(
          children: [
            const LogoTop(),
            _Canvas(size: MediaQuery.of(context).size),
          ],
        ),
      );
    });
  }
}

var now = DateTime.now();
var endTime = DateTime.utc(2021, 11, 29, 8, 00, 00).millisecondsSinceEpoch;
// int get endTime {
//   if (now.year == 2021 && now.month == 11 && (now.day == 29 || now.day == 30)) {
//     return DateTime.utc(now.year, now.month, now.day, 8, 00, 00)
//         .millisecondsSinceEpoch;
//   }
//   return DateTime.utc(2021, 11, 29, 8, 00, 00).millisecondsSinceEpoch;
// }

class LogoTop extends StatefulWidget {
  const LogoTop({Key? key}) : super(key: key);

  @override
  State<LogoTop> createState() => _LogoTopState();
}

class _LogoTopState extends State<LogoTop> with SingleTickerProviderStateMixin {
  TextStyle get titleTextStyle => const TextStyle(fontSize: 64);
  TextStyle get subtitleTextStyle => const TextStyle(fontSize: 36);
  TextStyle get timeTextStyle =>
      const TextStyle(fontSize: 28, color: Color(0xFF174C90));

  double get logoWidth => 320;
  late CountdownTimerController controller;

  @override
  void initState() {
    super.initState();
    controller =
        CountdownTimerController(endTime: endTime, onEnd: onEnd, vsync: this);
  }

  void onEnd() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.flutterkaigiLogo,
            width: logoWidth,
          ),
          Text('FlutterKaigi', style: titleTextStyle),
          const Gap(32),
          Text('@ONLINE / November 29-30, 2021', style: subtitleTextStyle),
          const Gap(32),
          CountdownTimer(
            controller: controller,
            // endTime: endTime,
            endWidget: const Center(child: Text('On Live!')),
            widgetBuilder: (_, CurrentRemainingTime? time) {
              if (time == null) {
                return Container();
              }
              return Center(
                child: Table(
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  children: [
                    TableRow(children: [
                      Center(
                          child: Text(sprintf("%02i", [time.days]),
                              style: timeTextStyle)),
                      const SizedBox(width: 8),
                      Center(
                          child: Text(sprintf("%02i", [time.hours]),
                              style: timeTextStyle)),
                      const SizedBox(width: 8),
                      Center(
                          child: Text(sprintf("%02i", [time.min]),
                              style: timeTextStyle)),
                      const SizedBox(width: 8),
                      Center(
                          child: Text(sprintf("%02i", [time.sec]),
                              style: timeTextStyle)),
                    ]),
                    const TableRow(children: [
                      Center(child: Text('Days')),
                      SizedBox(width: 16),
                      Center(child: Text('Hours')),
                      SizedBox(width: 16),
                      Center(child: Text('Mins')),
                      SizedBox(width: 16),
                      Center(child: Text('Secs')),
                    ]),
                  ],
                ),
              );
              // return Text(
              //     'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                    ],
                  ),
                ),
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
