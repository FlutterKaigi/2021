import 'package:confwebsite2021/data/staff.dart';
import 'package:confwebsite2021/gen/assets.gen.dart';
import 'package:confwebsite2021/responsive_layout_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffPage extends StatelessWidget {
  const StaffPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.staff),
      ),
      body: ResponsiveLayoutBuilder(builder: (context, layout, width) {
        return Container(
          alignment: Alignment.topCenter,
          child: GridView.extent(
            primary: false,
            padding: const EdgeInsets.all(24),
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            maxCrossAxisExtent: 100,
            children: kStaffList
                .map(
                  (e) => StaffItem(
                    name: e['name'] ?? '',
                    photo: e['photo'] ?? '',
                    url: e['url'] ?? '',
                  ),
                )
                .toList(),
          ),
        );
      }),
    );
  }
}

class StaffItem extends StatelessWidget {
  const StaffItem({
    Key? key,
    required this.name,
    required this.photo,
    required this.url,
  }) : super(key: key);
  final String name;
  final String photo;
  final String url;

  @override
  Widget build(BuildContext context) {
    // final image = (photo.isNotEmpty
    //     ? AssetImage(photo)
    //     : const Svg(Assets.flutterkaigiLog)) as ImageProvider;

    final image = (photo.isNotEmpty && validUrl(photo)
        ? NetworkImage(photo)
        : const Svg(Assets.flutterkaigiLogo)) as ImageProvider;

    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 64,
            width: 64,
            child: ClipOval(
              child: FadeInImage(
                fit: BoxFit.cover,
                image: image,
                placeholder: MemoryImage(kTransparentImage),
              ),
            ),
          ),
          Text(name),
        ],
      ),
    );
  }

  bool validUrl(String url) {
    try {
      Uri.parse(url);
    } on FormatException catch (_) {
      return false;
    }
    return true;
  }
}
