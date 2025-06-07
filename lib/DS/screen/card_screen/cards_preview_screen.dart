// lib/desygn_system/screens/cards_preview_screen.dart

import 'package:flutter/material.dart';
import 'package:loja/DS/components/appBar/appBar_custom.dart';
import 'package:loja/DS/components/cards/card/card.dart';
import 'package:loja/DS/components/cards/card/card_view_model.dart';
import 'package:loja/DS/shared/color/colors.dart';

class CardsPreviewScreen extends StatelessWidget {
  const CardsPreviewScreen({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(brandName: "Loja"),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          // Exemplo 1: Card de Produto Básico
          CustomCards(
            viewModel: CardViewMode(
              title: 'Smartwatch Ultra Pro',
              subtitle: 'Última geração, bateria de longa duração.',
              imageUrl:
                  'https://via.placeholder.com/150/FF0000/FFFFFF?text=Smartwatch',
              value: 1250.00,
              onTap: () {
                _showSnackBar(context, 'Card Smartwatch clicado!');
              },
              onDecrease: () {
                _showSnackBar(context, 'Diminuir quantidade de Smartwatch.');
              },
              onMoreOptions: () {
                _showSnackBar(context, 'Mais opções para Smartwatch.');
              },
            ),
          ),
          // Exemplo 2: Card de Serviço
          CustomCards(
            viewModel: CardViewMode(
              title: 'Plano de Internet 500MB',
              subtitle: 'Velocidade e estabilidade para sua casa.',
              imageUrl:
                  'https://via.placeholder.com/150/0000FF/FFFFFF?text=Internet',
              value: 99.90,
              onTap: () {
                _showSnackBar(context, 'Card Plano de Internet clicado!');
              },
              // onDecrease: null, // Este card não tem opção de diminuir
              onMoreOptions: () {
                _showSnackBar(context, 'Mais opções para Plano de Internet.');
              },
            ),
          ),
          // Exemplo 3: Card de Assinatura
          CustomCards(
            viewModel: CardViewMode(
              title: 'Assinatura Premium XYZ',
              subtitle: 'Acesso total a todos os recursos.',
              // Sem imagem de URL para mostrar o placeholder
              value: 49.99,
              onTap: () {
                _showSnackBar(context, 'Card Assinatura Premium clicado!');
              },
              onDecrease: () {
                _showSnackBar(context, 'Cancelar assinatura? (Simulado)');
              },
              // onMoreOptions: null, // Este card não tem mais opções
            ),
          ),
          // Exemplo 4: Card sem onDecrease e sem onMoreOptions
          CustomCards(
            viewModel: CardViewMode(
              title: 'Item de Biblioteca',
              subtitle: 'Um livro para leitura.',
              imageUrl:
                  'https://via.placeholder.com/150/FFFF00/000000?text=Livro',
              value: 0.00, // Valor pode ser zero para itens sem custo
              onTap: () {
                _showSnackBar(context, 'Card Livro clicado!');
              },
              // onDecrease é null
              // onMoreOptions é null
            ),
          ),
        ],
      ),
    );
  }
}
