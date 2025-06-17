import 'package:flutter/material.dart';
import 'package:loja/DS/components/appBar/appBar_custom.dart';
import 'package:loja/DS/components/cards/card_curstom2/custom_card2_view_model.dart';
import 'package:loja/DS/components/cards/enum/card_enums.dart';
import 'package:loja/DS/components/cards/listCard/list_card_custom.dart';
import 'package:loja/DS/components/loading/loading.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/screens/detal_screen.dart';
import 'package:loja/utils/post/post_model.dart';
import 'package:loja/utils/service/favorite_service.dart';

class FavorictsScreen extends StatefulWidget {
  const FavorictsScreen({super.key});

  @override
  State<FavorictsScreen> createState() => _FavorictsScreenState();
}

class _FavorictsScreenState extends State<FavorictsScreen> {
  late Future<List<PostModel>> _favoritesFuture;
  @override
  void initState() {
    super.initState();
    Loading(color: kBlueColor);
    _fetchFavorites();
  }

  void _fetchFavorites() {
    setState(() {
      _favoritesFuture = FavoriteService.getFavorites();
    });
  }

  List<CustomCard2ViewModel> _mapPostsToCardViewModels(List<PostModel> posts) {
    return posts.map((post) {
      return CustomCard2ViewModel(
        id: post.id,
        title: post.title,
        price: post.price,
        description: post.description,
        category: post.category,
        image: post.image,
        buttonText: 'Detalhes',
        onButtonPressed: (context) async {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Detalhes de ${post.title}')));
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetalScreen(produto: post)),
          );
          _fetchFavorites();
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomAppBar(brandName: "Meus Favoritos"),
      drawer: buildAppDrawer(context),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<PostModel>>(
              future: _favoritesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar favoritos: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum item favorito encontrado.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: kGray600),
                    ),
                  );
                } else {
                  final List<PostModel> favorites = snapshot.data!;
                  final List<CustomCard2ViewModel> cardViewModels =
                      _mapPostsToCardViewModels(favorites);
                  return ListCard(
                    cards: cardViewModels,
                    cardModelType: CardModelType.customCard2,
                    displayMode: CardDisplayMode.verticalList,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
