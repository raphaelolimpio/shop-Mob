// lib/DS/components/cards/card_Custom/custom_card.dart (AJUSTES FINOS DE ALINHAMENTO)
import 'package:flutter/material.dart';
import 'package:loja/DS/components/cards/card_Custom/custom_card_view_model.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';

class CustomCard extends StatelessWidget {
  final CustomCardViewModel viewModel;
  final double? cardWidth;

  const CustomCard({super.key, required this.viewModel, this.cardWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: kFontColorWhite,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: kGray500.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min, // Pode remover se a altura do card for fixa
        children: [
          SizedBox(
            height: 200, // Altura fixa para a área da imagem
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                viewModel.image,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value:
                          loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        kPrimaryAppColor,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: kGray200,
                    child: const Icon(
                      Icons.broken_image,
                      color: kGray500,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
          ),

          // Área de detalhes do produto (título, categoria, preço, botão)
          Expanded(
            // Use Expanded para que esta seção ocupe o espaço restante
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween, // Distribui o espaço entre os filhos
                children: [
                  Column(
                    // Agrupa título e categoria
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.title,
                        style: normalStyle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kDeepNavyBlue3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ), // Espaçamento pequeno entre título e categoria
                      Text(
                        viewModel.category.toUpperCase(),
                        style: smallStyle.copyWith(
                          fontSize: 11,
                          color: kGray500,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  // Separador entre info e preço (opcional, se quiser mais espaço)
                  // const SizedBox(height: 8),
                  Text(
                    'R\$ ${viewModel.price.toStringAsFixed(2)}',
                    style: priceStyle.copyWith(fontSize: 16),
                  ),

                  // O SizedBox(height: 10) antes do botão será removido
                  // pois mainAxisAlignment.spaceBetween já cuida do espaçamento
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => viewModel.onButtonPressed(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kDeepNavyBlue2,
                        side: const BorderSide(color: kDeepNavyBlue2, width: 1),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        textStyle: smallStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                      child: Text(viewModel.buttonText),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
