import 'package:confwebsite2021/router/simple_route.dart';
import 'package:confwebsite2021/pages/index.dart';
import 'package:flutter/material.dart';

Route<dynamic> buildRouters(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return defaultRoute();
    default:
      return defaultRoute();
  }
}

SimpleRoute defaultRoute() {
  return SimpleRoute(
      name: '/', title: 'FlutterKaigi 2021', builder: (context) => TopPage());
}