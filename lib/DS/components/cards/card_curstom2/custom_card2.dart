// lib/DS/components/cards/card_Custom/custom_card.dart (Revisão para evitar overflow)
import 'package:flutter/material.dart';
import 'package:loja/DS/components/cards/card_curstom2/custom_card2_view_model.dart';
import 'package:loja/DS/components/reactiveTask/reactive_task.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';
import 'package:loja/utils/service/cart_service.dart';
import 'package:loja/utils/service/favorite_service.dart';

class CustomCard2 extends StatefulWidget {
  final CustomCard2ViewModel viewModel;
  final double? cardWidth;

  const CustomCard2({super.key, required this.viewModel, this.cardWidth});

  @override
  State<CustomCard2> createState() => _CustomCard2State();
}

class _CustomCard2State extends State<CustomCard2> {
  late Future<bool> _isFavoritedFuture;
  late Future<bool> _isInCartFuture;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
    _checkCartStatus();
  }

  void _checkFavoriteStatus() {
    _isFavoritedFuture = FavoriteService.isFavorite(widget.viewModel.id);
    setState(() {});
  }

  void _checkCartStatus() {
    _isInCartFuture = CartService.isInCart(widget.viewModel.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SizedBox(
        width: widget.cardWidth,

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
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.viewModel.image,
                  height: 200,
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
                      widget.viewModel.title,
                      style: headingStyle.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kDeepNavyBlue3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.viewModel.category.toUpperCase(),
                    style: normalStyle.copyWith(
                      color: kGray700,
                      fontSize: 12.0,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FutureBuilder<bool>(
                    future: _isFavoritedFuture,
                    builder: (context, snapshot) {
                      bool isFavorited = snapshot.data ?? false;
                      return IconButton(
                        icon: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_border,
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
                                content: Text('Adicionado aos favoritos!'),
                              ),
                            );
                            _checkFavoriteStatus();
                          }
                        },
                        tooltip: isFavorited ? 'Desfavoritar' : 'Favoritar',
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
                                  await CartService.addToCart(removedItem);
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
                                content: Text('Adicionado ao carrinho!'),
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
              const SizedBox(height: 8),
              Text(
                'R\$ ${widget.viewModel.price.toStringAsFixed(2)}',
                style: headingStyle.copyWith(fontSize: 18.0),
              ),
              const SizedBox(height: 8),
              Text(
                widget.viewModel.description,
                style: smallStyle.copyWith(color: kGray600),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () => widget.viewModel.onButtonPressed(context),
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
                  child: Text(widget.viewModel.buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
