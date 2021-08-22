/// ref.
/// developer_quest/rpg_layout_builder.dart at master · 2d-inc/developer_quest https://github.com/2d-inc/developer_quest/blob/master/lib/src/rpg_layout_builder.dart
///
import 'package:flutter/material.dart';

/// Once the logic screen pixel width exceeds this number, show the ultrawide
/// layout.
const double ultraWideLayoutThreshold = 1200;

/// Once the logic screen pixel width exceeds this number, show the wide layout.
const double wideLayoutThreshold = 800;

/// Layout for the dev_rpg game.
enum ResponsiveLayout { slim, wide, ultrawide }

/// Signature for a function that builds a widget given an [ResponsiveLayout].
///
/// Used by [ResponsiveLayoutBuilder.builder].
typedef ResponsiveLayoutWidgetBuilder = Widget Function(
    BuildContext context, ResponsiveLayout layout, double width);

/// Builds a widget tree that can depend on the parent widget's width
class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    required this.builder,
    Key? key,
  }) : super(key: key);

  /// Builds the widgets below this widget given this widget's layout width.
  final ResponsiveLayoutWidgetBuilder builder;

  Widget _build(BuildContext context, BoxConstraints constraints) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final layout = mediaWidth >= ultraWideLayoutThreshold
        ? ResponsiveLayout.ultrawide
        : mediaWidth > wideLayoutThreshold
            ? ResponsiveLayout.wide
            : ResponsiveLayout.slim;
    return builder(context, layout, mediaWidth);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _build);
  }
}
