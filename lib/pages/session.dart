import 'package:confwebsite2021/data/speaker.dart';
import 'package:confwebsite2021/responsive_layout_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.session),
      ),
      body: ResponsiveLayoutBuilder(builder: (context, layout, width) {
        return Scrollbar(
            child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Tooltip(
                    message: appLocalizations.timetableOrder,
                    child: Text(
                      appLocalizations.timetableOrder,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: kSpeakerList.length,
                  padding: const EdgeInsets.only(top: 10.0),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          const DaySeparator(day: 1),
                          CardItem(
                            title: kSpeakerList[index]!['title'] ?? '',
                            name: kSpeakerList[index]!['name'] ?? '',
                            datetime: kSpeakerList[index]!['datetime'] ?? '',
                            twitter: kSpeakerList[index]!['twitter'] ?? '',
                            fortee: kSpeakerList[index]!['fortee'] ?? '',
                            youtube: kSpeakerList[index]!['youtube'] ?? '',
                          ),
                        ],
                      );
                    }
                    if (index == 6) {
                      return Column(
                        children: [
                          const DaySeparator(day: 2),
                          CardItem(
                            title: kSpeakerList[index]!['title'] ?? '',
                            name: kSpeakerList[index]!['name'] ?? '',
                            datetime: kSpeakerList[index]!['datetime'] ?? '',
                            twitter: kSpeakerList[index]!['twitter'] ?? '',
                            fortee: kSpeakerList[index]!['fortee'] ?? '',
                            youtube: kSpeakerList[index]!['youtube'] ?? '',
                          )
                        ],
                      );
                    }
                    return CardItem(
                      title: kSpeakerList[index]!['title'] ?? '',
                      name: kSpeakerList[index]!['name'] ?? '',
                      datetime: kSpeakerList[index]!['datetime'] ?? '',
                      twitter: kSpeakerList[index]!['twitter'] ?? '',
                      fortee: kSpeakerList[index]!['fortee'] ?? '',
                      youtube: kSpeakerList[index]!['youtube'] ?? '',
                    );
                  }),
            ],
          ),
        ));
      }),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.title,
    required this.name,
    required this.datetime,
    required this.twitter,
    required this.fortee,
    required this.youtube,
  }) : super(key: key);
  final String title;
  final String name;
  final String datetime;
  final String twitter;
  final String fortee;
  final String youtube;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Tooltip(
        message: appLocalizations.checkSessionDetailsInFortee,
        child: Card(
            elevation: 3,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                dense: true,
                leading: const Icon(Icons.movie),
                title: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(name,
                            style: const TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.normal)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(datetime,
                            style: const TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.normal)),
                      ),
                    ]),
                trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Tooltip(
                        message: twitter,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            '/twitter_logo.svg',
                            width: 40,
                          ),
                          onPressed: () async {
                            await launch(
                              twitter,
                              webOnlyWindowName: '_blank',
                            );
                          },
                        ),
                      ),
                    ]),
                onTap: () async {
                  await launch(
                    fortee,
                    webOnlyWindowName: '_blank',
                  );
                },
              ),
            ])));
  }
}

class DaySeparator extends StatelessWidget {
  const DaySeparator({
    Key? key,
    required this.day,
  }) : super(key: key);
  final int day;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Day $day',
      child: Card(
          elevation: 3,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            ListTile(
              dense: true,
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Day $day',
                        style: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.normal)),
                  ]),
            ),
          ])),
    );
  }
}
