import 'package:loja/DS/components/cards/base/base_card_view_model.dart';

class CardViewMode extends BaseCardViewModel {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final Function()? onTap;
  final double value;
  final Function()? onDecrease;
  final Function()? onMoreOptions;

  CardViewMode({
    required this.title,
    required this.subtitle,
    this.imageUrl,
    required this.value,
    this.onTap,
    this.onDecrease,
    this.onMoreOptions,
  });
}
