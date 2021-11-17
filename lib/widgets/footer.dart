import 'package:confwebsite2021/router/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final footerLinks = <Map<String, String>>[
      {
        'name': appLocalizations.codeOfConduct,
        'url':
            'https://flutterkaigi.github.io/flutterkaigi/Code-of-Conduct.ja.html',
      },
      {
        'name': appLocalizations.privacyPolicy,
        'url':
            'https://flutterkaigi.github.io/flutterkaigi/Privacy-Policy.ja.html',
      },
      {
        'name': appLocalizations.contactUs,
        'url':
            'https://docs.google.com/forms/d/e/1FAIpQLSemYPFEWpP8594MWI4k3Nz45RJzMS7pz1ufwtnX4t3V7z2TOw/viewform',
      },
    ];

    final footerItem = footerLinks.map((link) {
      return _FooterButton(
          message: link['name']!,
          text: link['name']!,
          onPressed: () async {
            await launch(link['url']!);
          });
    }).toList()
      ..add(
        _FooterButton(
            message: appLocalizations.session,
            text: appLocalizations.session,
            onPressed: () {
              Navigator.of(context).pushNamed(sessionRoute().settings.name!);
            }),
      )
      ..add(
        _FooterButton(
            message: appLocalizations.staff,
            text: appLocalizations.staff,
            onPressed: () {
              Navigator.of(context).pushNamed(staffRoute().settings.name!);
            }),
      )
      ..add(
        _FooterButton(
            message: appLocalizations.licenses,
            text: appLocalizations.licenses,
            onPressed: () {
              showLicensePage(
                context: context,
              );
            }),
      );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.center,
          children: footerItem,
        ),
        const Gap(8),
        _Acknowledgements(appLocalizations: appLocalizations),
        const Gap(8),
        Text(appLocalizations.copyright),
        const Gap(32),
      ],
    );
  }
}

class _Acknowledgements extends StatelessWidget {
  const _Acknowledgements({
    Key? key,
    required this.appLocalizations,
  }) : super(key: key);

  final AppLocalizations appLocalizations;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 0,
        ),
        child: Text(
          appLocalizations.acknowledgements,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  const _FooterButton({
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
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
