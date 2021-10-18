import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnpassButton extends StatelessWidget {
  const ConnpassButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(8),
      child: Tooltip(
        message: appLocalizations.openMainEventPage,
        child: ElevatedButton(
          onPressed: () async {
            await launch(
              'https://flutterkaigi.connpass.com/event/226034',
              webOnlyWindowName: '_blank',
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(24),
            primary: Colors.deepOrange,
            onPrimary: Colors.black87,
          ),
          child: Text(
            appLocalizations.applyMainEvent,
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
