import 'dart:async';
import 'dart:convert';

import 'package:confwebsite2021/entity/timetable_entity.dart';
import 'package:confwebsite2021/gen/assets.gen.dart';
import 'package:confwebsite2021/responsive_layout_builder.dart';
import 'package:confwebsite2021/theme.dart';
import 'package:confwebsite2021/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TimetablePage extends StatelessWidget {
  const TimetablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(builder: (context, layout, width) {
      return Scaffold(
        body: Stack(
          children: [
            const _Timetable(),
            BackgroundCanvas(size: MediaQuery.of(context).size),
          ],
        ),
      );
    });
  }
}

class _Timetable extends StatefulWidget {
  const _Timetable({Key? key}) : super(key: key);

  @override
  State<_Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<_Timetable>
    with SingleTickerProviderStateMixin {
  TextStyle get titleTextStyle => const TextStyle(fontSize: 64);
  TextStyle get subtitleTextStyle => const TextStyle(fontSize: 36);

  @override
  void initState() {
    super.initState();
  }

  Future<List<Timetable>> _getFutureValue() async {
    var response = await http
        .get(Uri.parse('https://fortee.jp/flutterkaigi-2021/api/timetable'));
    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      return Future.value(TimetableEntity.fromJson(jsonDecode(responseBody))
          .timetable
          .where((element) => element.type == 'talk')
          .toList());
    }
    return Future.value(TimetableEntity.empty().timetable);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Timetable>>(
      future: _getFutureValue(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return _SlidePage(timetable: snapshot.data!);
          // return Text(snapshot.data.toString());
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _SlidePage extends StatefulWidget {
  final List<Timetable> timetable;

  const _SlidePage({
    Key? key,
    required this.timetable,
  }) : super(key: key);

  @override
  State<_SlidePage> createState() => _SlidePageState();
}

class _SlidePageState extends State<_SlidePage> {
  final PageController _controller = PageController(initialPage: 1);
  final FocusNode _focusNode = FocusNode();
  Timer? _timer;

  @override
  void initState() {
    _timer =
        Timer.periodic(const Duration(seconds: 20), (_) => toggleSession());
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  bool showen = false;
  showSession() => setState(() => showen = false);
  showSessionList() => setState(() => showen = true);
  toggleSession() => setState(() => showen = !showen);

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKey: handleKeyEvent,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.timetable.length,
              itemBuilder: (context, index) {
                var current = widget.timetable[index];
                var list = widget.timetable
                    .where((e) => _compareDate(e.startsAt!, current.startsAt!))
                    .toList();
                var session = _Session(
                    key: ValueKey<String>(current.uuid!), timetable: current);
                var sessionList = _SessionList(
                  key: ValueKey<String>(current.startsAt!),
                  timetable: list,
                  current: current,
                );
                // _current ??= _session;
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 2000),
                  switchInCurve: Curves.ease,
                  switchOutCurve: Curves.ease,
                  child: showen ? sessionList : session,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.banner.image(height: 50.0),
            ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _Footer(),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(showen
                    ? Icons.expand_more_rounded
                    : Icons.expand_less_rounded),
              ),
              onTap: toggleSession,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.chevron_left_rounded),
              ),
              onTap: previousPage,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.chevron_right_rounded),
              ),
              onTap: nextPage,
            ),
          ),
        ],
      ),
    );
  }

  previousPage() => _controller.previousPage(
      duration: const Duration(milliseconds: 600), curve: Curves.ease);

  nextPage() => _controller.nextPage(
      duration: const Duration(milliseconds: 600), curve: Curves.ease);

  handleKeyEvent(RawKeyEvent event) {
    debugPrint(event.logicalKey.debugName);
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      showSessionList();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      showSession();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      previousPage();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      nextPage();
    } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
      previousPage();
    } else if (event.logicalKey == LogicalKeyboardKey.space) {
      if (showen) {
        showSession();
      } else {
        showSessionList();
      }
      // toggleSession();
    }
  }

  bool _compareDate(String a, String b) {
    return DateTime.parse(a).toLocal().day == DateTime.parse(b).toLocal().day;
  }
}

final df = DateFormat.jm();
speaker(Timetable timetable) {
  if (timetable.speaker == null) return '';
  var name =
      timetable.speaker!.name != null ? 'by ${timetable.speaker!.name!}' : '';
  var twitter = timetable.speaker!.twitter != null
      ? ' / @${timetable.speaker?.twitter!}'
      : '';
  return name + twitter;
}

class _Session extends StatelessWidget {
  final Timetable timetable;

  const _Session({Key? key, required this.timetable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startsAt = df.format(DateTime.parse(timetable.startsAt!).toLocal());

    return Card(
      child: Container(
        padding: const EdgeInsets.all(32.0),
        // decoration: const BoxDecoration(color: Colors.amber),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Next talk',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              startsAt,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              timetable.title!,
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              speaker(timetable),
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionList extends StatelessWidget {
  final List<Timetable> timetable;
  final Timetable current;

  const _SessionList({
    Key? key,
    required this.timetable,
    required this.current,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.centerLeft,
        child: ListView.separated(
          itemCount: timetable.length + 1,
          itemBuilder: (_, index) {
            if (index == 0) {
              return Text(
                'Today\'s talks',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kBlue),
              );
            }
            var item = timetable[index - 1];
            final startsAt =
                df.format(DateTime.parse(item.startsAt!).toLocal());

            return ListTile(
              leading: Text(
                startsAt,
                style: Theme.of(context).textTheme.headline6,
              ),
              title: Text(
                item.title!,
                style: Theme.of(context).textTheme.headline5,
                maxLines: 1,
              ),
              subtitle: Text(
                speaker(item),
                style: Theme.of(context).textTheme.headline6,
              ),
              trailing: item.uuid == current.uuid
                  ? Text(
                      'NEXT',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: kSkyblue),
                    )
                  : null,
            );
          },
          separatorBuilder: (context, index) {
            var color =
                index == 0 || (timetable[index - 1].uuid != current.uuid)
                    ? null
                    : kSkyblue;
            return Divider(color: color);
          },
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          AppLocalizations.of(context)?.acknowledgements ?? '',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
