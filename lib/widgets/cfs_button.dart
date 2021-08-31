import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class CfsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(8),
      child: Tooltip(
        message: appLocalizations.submitProposal,
        child: ElevatedButton(
          onPressed: () async {
            await launch(
              'https://fortee.jp/flutterkaigi-2021/speaker/proposal/cfp',
              webOnlyWindowName: '_blank',
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(24),
            primary: Colors.deepOrange,
            onPrimary: Colors.white54,
          ),
          child: Text(
            appLocalizations.proposalSubmissionStart,
            style: const TextStyle(
              color: Colors.white,
              backgroundColor: Colors.deepOrange,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
