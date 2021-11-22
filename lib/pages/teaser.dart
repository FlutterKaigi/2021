import 'package:confwebsite2021/gen/assets.gen.dart';
import 'package:confwebsite2021/responsive_layout_builder.dart';
import 'package:confwebsite2021/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sprintf/sprintf.dart';

class TeaserPage extends StatelessWidget {
  const TeaserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(builder: (context, layout, width) {
      return Scaffold(
        body: Stack(
          children: [
            const _Teaser(),
            BackgroundCanvas(size: MediaQuery.of(context).size),
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

class _Teaser extends StatefulWidget {
  const _Teaser({Key? key}) : super(key: key);

  @override
  State<_Teaser> createState() => _TeaserState();
}

class _TeaserState extends State<_Teaser> with SingleTickerProviderStateMixin {
  TextStyle get titleTextStyle => const TextStyle(fontSize: 64);
  TextStyle get subtitleTextStyle => const TextStyle(fontSize: 36);
  TextStyle get timeTextStyle =>
      const TextStyle(fontSize: 28, color: Color(0xFF174C90));

  double get logoWidth => 320;
  late CountdownTimerController controller;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    controller =
        CountdownTimerController(endTime: endTime, onEnd: onEnd, vsync: this);
    audioPlayer = AudioPlayer();
    audioPlayer.setLoopMode(LoopMode.all);
    audioPlayer.setAsset(Assets.music.bensoundDreams);
    audioPlayer.play();
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
          Center(
            child: Text(
              '@ONLINE / November 29-30, 2021',
              style: subtitleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
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
    audioPlayer.dispose();
    super.dispose();
  }
}
