import 'package:flutter/material.dart';
import 'package:loja/DS/components/cards/card/card_view_model.dart';
import 'package:loja/DS/components/cards/card_Custom/custom_card_view_model.dart';
import 'package:loja/DS/components/cards/enum/card_enums.dart';
import 'package:loja/DS/components/cards/listCard/list_card_custom.dart';

class ListCardScreen extends StatelessWidget {
  const ListCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CustomCardViewModel> customCards = [
      CustomCardViewModel(
        title: 'Notícia Urgente',
        description: 'Uma notícia muito importante que você precisa ler.',
        category: 'Urgente',
        image: 'https://via.placeholder.com/150/FF0000/FFFFFF?text=Notícia',
        price:
            0.0, // Preço não é usado no CustomCard, mas necessário para o modelo
        buttonText: 'Ler Mais',
        onButtonPressed:
            (ctx) => ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Ler Mais Notícia Urgente')),
            ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Cards Flexíveis')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Cards Padrão (Lista Vertical)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Exibindo Cards Padrão em lista vertical

            // Exibindo Cards Customizados em lista horizontal
            ListCard(
              cards: customCards, // Passando a lista de customCards
              cardModelType:
                  CardModelType.customCard, // Especificando o tipo de card
              displayMode:
                  CardDisplayMode
                      .horizontalScroll, // Especificando o modo de visualização
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Mais Cards Padrão (Lista Horizontal - Exemplo Netflix)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Você pode adicionar mais ListCards aqui com diferentes configurações
          ],
        ),
      ),
    );
  }
}
