import 'package:flutter/material.dart';
import 'package:loja/DS/components/cards/card_Custom/custom_card_view_model.dart';
import 'package:loja/DS/components/reactiveTask/reactive_task.dart';

import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';
import 'package:loja/utils/service/cart_service.dart';
import 'package:loja/utils/service/favorite_service.dart';

class CustomCard extends StatefulWidget {
  final CustomCardViewModel viewModel;
  final double? cardWidth;

  const CustomCard({super.key, required this.viewModel, this.cardWidth});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late Future<bool> _isFavoritedFuture;
  late Future<bool> _isInCartFuture;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
    _checkCartStatus();
  }

  void _checkFavoriteStatus() {
    setState(() {
      _isFavoritedFuture = FavoriteService.isFavorite(widget.viewModel.id);
    });
  }

  void _checkCartStatus() {
    setState(() {
      _isInCartFuture = CartService.isInCart(widget.viewModel.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.cardWidth,
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
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                widget.viewModel.image,
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
                      valueColor: const AlwaysStoppedAnimation<Color>(
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

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.viewModel.title,
                        style: normalStyle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kDeepNavyBlue3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FutureBuilder<bool>(
                            future: _isFavoritedFuture,
                            builder: (context, snapshot) {
                              bool isFavorited = snapshot.data ?? false;
                              return IconButton(
                                icon: Icon(
                                  isFavorited
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  if (isFavorited) {
                                    final removedItem =
                                        await FavoriteService.removeFavorite(
                                          widget.viewModel.id,
                                        );
                                    if (removedItem != null) {
                                      ReactiveTask.showUndoSnackBar(
                                        context: context,
                                        message: 'Item removido dos favoritos.',
                                        onUndo: () async {
                                          await FavoriteService.addFavorite(
                                            removedItem,
                                          );
                                          _checkFavoriteStatus();
                                        },
                                      );
                                      _checkFavoriteStatus();
                                    }
                                  } else {
                                    await FavoriteService.addFavorite(
                                      widget.viewModel.toPostModel(),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Adicionado aos favoritos!',
                                        ),
                                      ),
                                    );
                                    _checkFavoriteStatus();
                                  }
                                },
                                tooltip:
                                    isFavorited ? 'Desfavoritar' : 'Favoritar',
                              );
                            },
                          ),
                          FutureBuilder<bool>(
                            future: _isInCartFuture,
                            builder: (context, snapshot) {
                              bool isInCart = snapshot.data ?? false;
                              return IconButton(
                                icon: Icon(
                                  isInCart
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined,
                                  color: Colors.blue,
                                ),
                                onPressed: () async {
                                  if (isInCart) {
                                    final removedItem =
                                        await CartService.removeFromCart(
                                          widget.viewModel.id,
                                        );
                                    if (removedItem != null) {
                                      ReactiveTask.showUndoSnackBar(
                                        context: context,
                                        message: 'Item removido do carrinho.',
                                        onUndo: () async {
                                          await CartService.addToCart(
                                            removedItem,
                                          );
                                          _checkCartStatus();
                                        },
                                      );
                                      _checkCartStatus();
                                    }
                                  } else {
                                    await CartService.addToCart(
                                      widget.viewModel.toPostModel(),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Adicionado ao carrinho!',
                                        ),
                                      ),
                                    );
                                    _checkCartStatus();
                                  }
                                },
                                tooltip:
                                    isInCart
                                        ? 'Remover do carrinho'
                                        : 'Adicionar ao carrinho',
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 1),
                      Text(
                        widget.viewModel.category.toUpperCase(),
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

                  Text(
                    'R\$ ${widget.viewModel.price.toStringAsFixed(2)}',
                    style: priceStyle.copyWith(fontSize: 16),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed:
                          () => widget.viewModel.onButtonPressed(context),
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
                      child: Text(widget.viewModel.buttonText),
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
