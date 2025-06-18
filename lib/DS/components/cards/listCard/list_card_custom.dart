import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:loja/DS/components/cards/card_curstom2/custom_card2.dart';
import 'package:loja/DS/components/cards/card_curstom2/custom_card2_view_model.dart';
import 'package:loja/DS/components/cards/base/base_card_view_model.dart';
import 'package:loja/DS/components/cards/card/card.dart' as DefaultCardWidget;
import 'package:loja/DS/components/cards/card/card_view_model.dart';
import 'package:loja/DS/components/cards/card_Custom/custom_card.dart'
    as CustomCardWidget;

import 'package:loja/DS/components/cards/card_Custom/custom_card_view_model.dart';
import 'package:loja/DS/components/cards/enum/card_enums.dart';

class ListCard extends StatelessWidget {
  final List<BaseCardViewModel> cards;
  final CardModelType cardModelType;
  final CardDisplayMode displayMode;
  final double? listHeight;
  final ScrollController? scrollController;

  const ListCard({
    super.key,
    required this.cards,
    this.cardModelType = CardModelType.defaultCard,
    this.displayMode = CardDisplayMode.verticalList,
    this.listHeight,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double responsiveCardWidth = screenWidth * 0.75;
    final double responsiveCardMax = Math.min(screenWidth * 0.75, 300.0);

    Widget _buildCardWidget(BaseCardViewModel viewModel) {
      switch (cardModelType) {
        case CardModelType.defaultCard:
          if (viewModel is CardViewModel) {
            return DefaultCardWidget.ProductCard(
              viewModel: viewModel,
              cardWidth:
                  displayMode == CardDisplayMode.horizontalScroll
                      ? responsiveCardWidth
                      : null,
            );
          }
          return Text('Erro: ViewModel inesperado para Default Card');
        case CardModelType.customCard:
          if (viewModel is CustomCardViewModel) {
            return CustomCardWidget.CustomCard(
              viewModel: viewModel,
              cardWidth:
                  displayMode == CardDisplayMode.horizontalScroll
                      ? responsiveCardMax
                      : null,
            );
          }
          return Text('Erro: ViewModel inesperado para Custom Card');
        case CardModelType.customCard2:
          if (viewModel is CustomCard2ViewModel) {
            return CustomCard2(
              viewModel: viewModel,
              cardWidth:
                  displayMode == CardDisplayMode.horizontalScroll
                      ? responsiveCardWidth
                      : null,
            );
          }
          return Text('Erro: ViewModel inesperado para Custom Card');
      }
    }

    if (displayMode == CardDisplayMode.verticalList) {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return _buildCardWidget(cards[index]);
        },
      );
    } else {
      return SizedBox(
        height: listHeight ?? 420,
        child: RawScrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: _buildCardWidget(cards[index]),
              );
            },
          ),
        ),
      );
    }
  }
}
