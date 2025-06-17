// lib/screens/detal_screen.dart
import 'package:flutter/material.dart';
import 'package:loja/DS/components/appBar/appBar_custom.dart';
import 'package:loja/DS/components/cards/card/card.dart';
import 'package:loja/DS/components/cards/card/card_view_model.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/utils/post/post_model.dart';
import 'package:loja/utils/service/cart_service.dart';

class DetalScreen extends StatelessWidget {
  final PostModel produto;

  const DetalScreen({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardViewModel = CardViewModel(
      id: produto.id,
      title: produto.title,
      price: produto.price,
      description: produto.description,
      category: produto.category,
      image: produto.image,
      buttonText: 'Adicionar ao Carrinho',
      onButtonPressed: (context) async {
        await CartService.addToCart(produto);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${produto.title} adicionado ao carrinho!')),
        );
      },
    );

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomAppBar(brandName: "Detalhes do Produto"),
      drawer: buildAppDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: ProductCard(viewModel: cardViewModel),
        ),
      ),
    );
  }
}
