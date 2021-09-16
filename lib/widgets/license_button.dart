import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LicenseButton extends StatelessWidget {
  const LicenseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(8),
      child: Tooltip(
        message: appLocalizations.showLicense,
        child: TextButton(
          onPressed: () {
            showLicensePage(
              context: context,
            );
          },
          child: Text(appLocalizations.showLicense),
        ),
      ),
    );
  }
}