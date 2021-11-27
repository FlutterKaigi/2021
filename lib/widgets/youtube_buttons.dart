import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class YouTubeButtons extends StatelessWidget {
  const YouTubeButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final youTubeLinks = <Map<String, String>>[
      {
        'name': 'Day 1',
        'message': appLocalizations.showDay1,
        'url': 'https://www.youtube.com/watch?v=HnyOED0jdlA',
      },
      {
        'name': 'Day 2',
        'message': appLocalizations.showDay2,
        'url': 'https://www.youtube.com/watch?v=5tT0v2EpWYA ',
      },
    ];

    final youTubeItem = youTubeLinks.map((link) {
      return _YouTubeButton(
          message: link['message']!,
          text: link['name']!,
          onPressed: () async {
            await launch(link['url']!);
          });
    }).toList();

    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...youTubeItem]),
    );
  }
}

class _YouTubeButton extends StatelessWidget {
  const _YouTubeButton({
    Key? key,
    required this.message,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String message;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        width: 120,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(24),
            primary: Colors.deepOrange,
            onPrimary: Colors.black87,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
