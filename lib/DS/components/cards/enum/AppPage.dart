import 'package:flutter/material.dart';
import 'package:loja/screens/Favoricts_screen.dart';
import 'package:loja/screens/Product_all_screen.dart';
import 'package:loja/screens/buy_Screen.dart';
import 'package:loja/screens/history_screen%20.dart';
import 'package:loja/screens/product_screen.dart';

enum AppPage { home, allProducts, favorites, cart, history }

extension AppPageExtension on AppPage {
  String get label {
    switch (this) {
      case AppPage.home:
        return 'Home';
      case AppPage.allProducts:
        return 'Todos os Produtos';
      case AppPage.favorites:
        return 'Favoritos';
      case AppPage.cart:
        return 'Carrinho';
      case AppPage.history:
        return 'Histórico';
    }
  }

  IconData get icon {
    switch (this) {
      case AppPage.home:
        return Icons.home;
      case AppPage.allProducts:
        return Icons.list;
      case AppPage.favorites:
        return Icons.favorite;
      case AppPage.cart:
        return Icons.shopping_bag;
      case AppPage.history:
        return Icons.history;
    }
  }

  Widget get page {
    switch (this) {
      case AppPage.home:
        return const ProductsScreen();
      case AppPage.allProducts:
        return const ProductAllScreen();
      case AppPage.favorites:
        return const FavorictsScreen();
      case AppPage.cart:
        return const BuyScreen();
      case AppPage.history:
        return const HistoryScreen();
    }
  }
}
