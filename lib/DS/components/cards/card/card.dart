import 'package:flutter/material.dart';
import 'package:loja/DS/components/cards/card/card_view_model.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';
import 'package:intl/intl.dart';

class CustomCards extends StatelessWidget {
  final CardViewMode viewModel;

  final double? cardWidth; // <- NOVO

  const CustomCards({
    super.key,
    required this.viewModel,
    this.cardWidth, // <- NOVO
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );
    final formattedValue = currencyFormatter.format(viewModel.value);

    return SizedBox(
      // <- ENVOLVA O CARD COM UM SIZEDBOX
      width: cardWidth, // <- APLICA A LARGURA SE FORNEcida
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: InkWell(
          onTap: viewModel.onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: kGray300,
                  backgroundImage:
                      viewModel.imageUrl != null &&
                              viewModel.imageUrl!.isNotEmpty
                          ? NetworkImage(viewModel.imageUrl!)
                          : null,
                  child:
                      viewModel.imageUrl == null || viewModel.imageUrl!.isEmpty
                          ? Icon(Icons.shopping_bag, size: 30, color: kGray600)
                          : null,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  // Este Expanded está ok, desde que o pai (Row) tenha largura definida
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.title,
                        style: normalStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: kFontColorBlack,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        viewModel.subtitle,
                        style: smallStyle.copyWith(color: kGray700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formattedValue,
                      style: normalStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: appNormalCyanColor,
                      ),
                    ),
                    if (viewModel.onDecrease != null)
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: kRed500,
                        ),
                        onPressed: viewModel.onDecrease,
                        tooltip: 'Diminuir Quantidade',
                      ),
                  ],
                ),
                if (viewModel.onMoreOptions != null)
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: kGray700),
                    onPressed: viewModel.onMoreOptions,
                    tooltip: 'Mais Opções',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
