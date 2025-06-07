import 'package:flutter/material.dart';

enum AppRoute { timeline, postDetail }

class RouterManager extends StatelessWidget {
  const RouterManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rotas Nomeadas",
      theme: ThemeData(),
      initialRoute: AppRoutes.getRoute(AppRoute.timeline),
      routes: AppRoutes.routes(),
    );
  }
}

class AppRoutes {
  static const Map<AppRoute, String> _routesNames = {
    AppRoute.timeline: "/timeline",
    AppRoute.postDetail: "/postDetail",
  };

  static String getRoute(AppRoute route) => _routesNames[route]!;

  static Map<String, WidgetBuilder> routes() => {
    getRoute(AppRoute.timeline): (context) => Container(),
    getRoute(AppRoute.postDetail): (context) => Container(),
  };
}
