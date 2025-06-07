// lib/DS/components/cards/card_Custom/custom_card.dart (Revisão para evitar overflow)
import 'package:flutter/material.dart';
import 'package:loja/DS/components/cards/card_curstom2/custom_card2_view_model.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';

class CustomCard2 extends StatelessWidget {
  final CustomCard2ViewModel viewModel;
  final double? cardWidth;

  const CustomCard2({super.key, required this.viewModel, this.cardWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SizedBox(
        width: cardWidth,

        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: kFontColorWhite,
            border: Border.all(color: kGray300),
            borderRadius: BorderRadius.circular(12),
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
            // MainAxisSize.min para a coluna se ajustar ao conteúdo
            mainAxisSize:
                MainAxisSize.min, // Adicione isso para a coluna se contrair
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  viewModel.image,
                  height: 200, // Altura fixa para a imagem é bom
                  width: double.infinity,
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
                      height: 120,
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
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      viewModel.title,
                      style: headingStyle.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kDeepNavyBlue3,
                      ),
                      maxLines: 2, // Limite de linhas
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    viewModel.category.toUpperCase(),
                    style: normalStyle.copyWith(
                      color: kGray700,
                      fontSize: 12.0,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1, // Limite de linhas
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'R\$ ${viewModel.price.toStringAsFixed(2)}',
                style: headingStyle.copyWith(fontSize: 18.0),
              ),
              const SizedBox(height: 8),
              Text(
                viewModel.description,
                style: smallStyle.copyWith(color: kGray600),
                maxLines: 3, // Limite de linhas
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () => viewModel.onButtonPressed(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    textStyle: normalStyle.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: kDeepNavyBlue2,
                    foregroundColor: kFontColorWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(viewModel.buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
