import 'package:flutter/material.dart';
import 'package:loja/DS/components/appBar/appBar_custom.dart';
import 'package:loja/DS/components/loading/loading.dart';
import 'package:loja/DS/components/reactiveTask/reactive_task.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';
import 'package:loja/screens/history_screen%20.dart';
import 'package:loja/utils/post/post_model.dart';
import 'package:loja/utils/service/cart_service.dart';
import 'package:loja/utils/service/history_service.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  late Future<List<PostModel>> _cartItemsFuture;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    Loading(color: kBlueColor);
    _fetchCartItems();
  }

  void _fetchCartItems() {
    setState(() {
      _cartItemsFuture = CartService.getCartItems();
      _cartItemsFuture.then((items) {
        _calculateTotalPrice(items);
      });
    });
  }

  void _calculateTotalPrice(List<PostModel> items) {
    double total = 0.0;
    for (var item in items) {
      total += item.price;
    }
    setState(() {
      _totalPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth > 600;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomAppBar(brandName: "Meu Carrinho"),
      drawer: buildAppDrawer(context),
      body: FutureBuilder<List<PostModel>>(
        future: _cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar carrinho: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Seu carrinho está vazio.',
                style: TextStyle(fontSize: 18, color: kGray600),
              ),
            );
          } else {
            final List<PostModel> cartItems = snapshot.data!;

            Widget cartListPanel = Expanded(
              flex: isLargeScreen ? 2 : 1,
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 2,
                    child: ListTile(
                      leading: Image.network(
                        item.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                      ),
                      title: Text(item.title, style: normalStyle),
                      subtitle: Text(
                        'R\$ ${item.price.toStringAsFixed(2)}',
                        style: priceStyle.copyWith(fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: kRed500),
                        onPressed: () async {
                          final removedItem = await CartService.removeFromCart(
                            item.id,
                          );
                          if (removedItem != null) {
                            ReactiveTask.showUndoSnackBar(
                              context: context,
                              message:
                                  '${removedItem.title} removido do carrinho.',
                              onUndo: () async {
                                await CartService.addToCart(removedItem);
                                _fetchCartItems();
                              },
                            );
                            _fetchCartItems();
                          }
                        },
                      ),
                      onTap: () {},
                    ),
                  );
                },
              ),
            );

            Widget paymentSummaryPanel = Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: kGray100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Resumo da Compra', style: sectionHeadingStyle),
                    const SizedBox(height: 16),
                    Text(
                      'Total: R\$ ${_totalPrice.toStringAsFixed(2)}',
                      style: headingStyle.copyWith(
                        fontSize: 22,
                        color: kDeepNavyBlue3,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text('Opções de Pagamento', style: subHeadingStyle),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (cartItems.isNotEmpty) {
                          await HistoryService.addItemsToHistory(cartItems);
                          await CartService.clearCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Boleto gerado e compra finalizada!',
                              ),
                            ),
                          );
                          _fetchCartItems();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Carrinho vazio. Adicione itens antes de comprar.',
                              ),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.receipt_long,
                        color: kFontColorWhite,
                      ),
                      label: const Text('Gerar Boleto'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appGreenColor,
                        foregroundColor: kFontColorWhite,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Funcionalidade de Cartão (simulado)',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.credit_card,
                        color: kFontColorWhite,
                      ),
                      label: const Text('Adicionar Cartão'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kDeepNavyBlue2,
                        foregroundColor: kFontColorWhite,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Funcionalidade de Pix (simulado)'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.qr_code, color: kFontColorWhite),
                      label: const Text('Gerar Pix'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appNormalCyanColor,
                        foregroundColor: kFontColorWhite,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistoryScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.history, color: kFontColorWhite),
                      label: const Text('Ver Histórico de Compras'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGray700,
                        foregroundColor: kFontColorWhite,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );

            return isLargeScreen
                ? Row(children: [cartListPanel, paymentSummaryPanel])
                : Column(children: [cartListPanel, paymentSummaryPanel]);
          }
        },
      ),
    );
  }
}
