import 'package:confwebsite2021/pages/index.dart';
import 'package:confwebsite2021/pages/session.dart';
import 'package:confwebsite2021/pages/staff.dart';
import 'package:confwebsite2021/router/simple_route.dart';
import 'package:flutter/material.dart';

Route<dynamic> buildRouters(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return defaultRoute();
    case '/staff':
      return staffRoute();
    case '/session':
      return sessionRoute();
    default:
      return defaultRoute();
  }
}

SimpleRoute defaultRoute() {
  return SimpleRoute(
      name: '/',
      title: 'FlutterKaigi 2021',
      builder: (context) => const TopPage());
}

SimpleRoute staffRoute() {
  return SimpleRoute(
      name: '/staff', title: 'Staff', builder: (context) => const StaffPage());
}

SimpleRoute sessionRoute() {
  return SimpleRoute(
      name: '/session',
      title: 'Session',
      builder: (context) => const SessionPage());
}
