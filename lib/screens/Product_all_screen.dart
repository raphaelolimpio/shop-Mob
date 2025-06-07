// lib/screens/products/products_screen.dart
import 'package:flutter/material.dart';
import 'package:loja/DS/components/appBar/appBar_custom.dart';

import 'package:loja/DS/components/cards/card_curstom2/custom_card2_view_model.dart';
import 'package:loja/DS/components/cards/enum/card_enums.dart';
import 'package:loja/DS/components/cards/listCard/list_card_custom.dart';

import 'package:loja/utils/api/Api_Service.dart';
import 'package:loja/utils/post/post_model.dart';
import 'package:loja/utils/service/product_service.dart';

class ProductAllScreen extends StatefulWidget {
  const ProductAllScreen({super.key});

  @override
  State<ProductAllScreen> createState() => _ProductAllScreenState(); // _ProductsAllScreenState();
}

class _ProductAllScreenState extends State<ProductAllScreen> {
  late Future<ApiResponse<List<PostModel>>> _productsFuture;
  late Future<ApiResponse<List<String>>> _categoriesFuture;

  String? _selectedCategory;

  @override
  void initState() {
    super.initState();

    _fetchProducts();
    _categoriesFuture = ProductService.getAllCategories();
  }

  void _fetchProducts() {
    setState(() {
      // Chame o método do ProductService
      _productsFuture = ProductService.getProducts(category: _selectedCategory);
    });
  }

  List<CustomCard2ViewModel> _mapPostsToCardViewModels(List<PostModel> posts) {
    return posts.map((post) {
      return CustomCard2ViewModel(
        title: post.title,
        price: post.price,
        description: post.description,
        category: post.category,
        image: post.image,
        buttonText: 'Detalhes',
        onButtonPressed: (context) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Comprar ${post.title}')));
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(brandName: 'Loja'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<ApiResponse<List<String>>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.data == null) {
                  return const Text('Não foi possível carregar categorias.');
                } else {
                  final categories = ['Todas', ...snapshot.data!.data!];
                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por Categoria',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    value: _selectedCategory ?? 'Todas',
                    items:
                        categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                        _fetchProducts();
                      });
                    },
                  );
                }
              },
            ),
          ),
          const Divider(height: 20, thickness: 1),
          Expanded(
            child: FutureBuilder<ApiResponse<List<PostModel>>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar produtos: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (snapshot.hasData) {
                  final apiResponse = snapshot.data!;
                  if (apiResponse.statusCode >= 200 &&
                      apiResponse.statusCode < 300 &&
                      apiResponse.data != null) {
                    final List<PostModel> products = apiResponse.data!;
                    if (products.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhum produto encontrado para esta categoria.',
                        ),
                      );
                    }
                    final List<CustomCard2ViewModel> cardViewModels =
                        _mapPostsToCardViewModels(products);
                    return ListCard(
                      cards: cardViewModels,
                      cardModelType: CardModelType.customCard2,
                      displayMode: CardDisplayMode.verticalList,
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Falha na API: ${apiResponse.statusCode} - ${apiResponse ?? "Erro desconhecido"}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                }
                return const Center(child: Text('Carregando...'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
