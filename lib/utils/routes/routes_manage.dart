import 'package:flutter/material.dart';
import 'package:loja/DS/components/appBar/appBar_custom.dart';
import 'package:loja/screens/Product_all_screen.dart';
import 'package:loja/screens/detal_screen.dart';
import 'package:loja/screens/product_screen.dart';

enum AppRoute { home, allProducts, postDetail }

class RouterManager extends StatelessWidget {
  const RouterManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rotas Nomeadas",
      theme: ThemeData(),
      initialRoute: AppRoutes.getRoute(AppRoute.home),
      routes: AppRoutes.routes(),
    );
  }
}

class AppRoutes {
  static const Map<AppRoute, String> _routesNames = {
    AppRoute.home: "/home",
    AppRoute.allProducts: "/allProducts",
    AppRoute.postDetail: "/postDetail",
  };

  static String getRoute(AppRoute route) => _routesNames[route]!;

  static Map<String, WidgetBuilder> routes() => {
    getRoute(AppRoute.home): (context) => const ProductsScreen(),
    getRoute(AppRoute.allProducts): (context) => const ProductAllScreen(),
    getRoute(AppRoute.postDetail): (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map && args.containsKey('produto')) {
        return DetalScreen(produto: args['produto']);
      }

      return const Scaffold(
        appBar: CustomAppBar(brandName: "Erro"),
        body: Center(
          child: Text("Erro: Produto não encontrado para Detalhes."),
        ),
      );
    },
  };
}
