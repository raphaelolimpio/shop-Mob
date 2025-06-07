// lib/desygn_system/components/cards/card_Custom/custom_card_view_model.dart
import 'package:flutter/material.dart';
import 'package:loja/DS/components/cards/base/base_card_view_model.dart';

class CustomCardViewModel extends BaseCardViewModel {
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final String buttonText;
  final void Function(BuildContext context) onButtonPressed;

  CustomCardViewModel({
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.buttonText,
    required this.onButtonPressed,
  });
}
