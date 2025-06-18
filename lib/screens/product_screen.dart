import 'package:flutter/material.dart';
import 'package:loja/DS/components/appBar/appBar_custom.dart';
import 'package:loja/DS/components/cards/card_Custom/custom_card_view_model.dart';
import 'package:loja/DS/components/cards/enum/card_enums.dart';
import 'package:loja/DS/components/cards/listCard/list_card_custom.dart';
import 'package:loja/DS/components/loading/loading.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';
import 'package:loja/screens/Product_all_screen.dart';
import 'package:loja/screens/detal_screen.dart';
import 'package:loja/utils/api/Api_Service.dart';
import 'package:loja/utils/post/post_model.dart';
import 'package:loja/utils/service/Service.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<ApiResponse<List<PostModel>>> _productsFuture;
  final String historyTitle = "Sua História, Sua Conexão, Seu Brilho.";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Loading(color: kBlueColor);
    _productsFuture = Service.getPosts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<CustomCardViewModel> _mapPostsToCardViewModels(List<PostModel> posts) {
    return posts.map((post) {
      return CustomCardViewModel(
        id: post.id,
        title: post.title,
        price: post.price,
        description: post.description,
        category: post.category,
        image: post.image,
        buttonText: 'VER DETALHES',
        onButtonPressed: (context) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Detalhes de: ${post.title}')));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetalScreen(produto: post)),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomAppBar(brandName: "Loja"),
      drawer: buildAppDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: kDeepNavyBlue1,
                image: DecorationImage(
                  image: AssetImage('assets/history.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black54,
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 40.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      historyTitle,
                      style: headingStyle.copyWith(
                        fontSize: 28,
                        color: kElegantGold4,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Na nossa loja,não vendemos apenas produtos; oferecemos as peças que completam a sua narrativa.\n\n"
                      "Imagine-se: cada roupa que você veste não é só tecido, mas uma declaração de quem você é, criada para realçar sua confiança e autenticidade em cada passo da sua jornada.\n\n"
                      "Pense nos dispositivos que o acompanham: não são apenas circuitos, mas as ferramentas que conectam você ao mundo, à sua paixão, à sua próxima grande ideia, amplificando cada experiência.\n\n"
                      "E sinta o toque das joias: elas não são meros adornos, mas elos preciosos que celebram seus momentos únicos, irradiando a sua essência e a sua história mais íntima.\n\n"
                      "Acreditamos que o extraordinário está nos detalhes, na qualidade que inspira e na experiência que permanece. Aqui, cada escolha é um passo em direção à sua melhor versão, onde estilo, inovação e emoção se encontram para criar algo verdadeiramente seu.",
                      textAlign: TextAlign.left,
                      style: normalStyle.copyWith(
                        fontSize: 15,
                        color: kSoftCream1,
                        height: 1.4,
                      ),
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Conheça Nossa Filosofia clicado!'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kAccentColor,
                          foregroundColor: kDeepNavyBlue1,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 0,
                          textStyle: normalStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 0.8,
                          ),
                        ),
                        child: const Text('CONHEÇA NOSSA FILOSOFIA'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'COLEÇÕES CRIADAS PARA VOCÊ',
                style: sectionHeadingStyle.copyWith(
                  fontSize: 22,
                  color: kDeepNavyBlue2,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 20),

            FutureBuilder<ApiResponse<List<PostModel>>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        'Erro ao carregar produtos: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: normalStyle.copyWith(color: kRed500),
                      ),
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
                        child: Text('Nenhum produto encontrado.'),
                      );
                    }

                    final List<PostModel> featuredProducts =
                        products.take(8).toList();

                    final List<CustomCardViewModel> cardViewModels =
                        _mapPostsToCardViewModels(featuredProducts);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 420,
                              child: ListCard(
                                cards: cardViewModels,
                                cardModelType: CardModelType.customCard,
                                displayMode: CardDisplayMode.horizontalScroll,
                                listHeight: 420,
                                scrollController: _scrollController,
                              ),
                            ) /*
                            Positioned(
                              left: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: kGray700,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _scrollController.animateTo(
                                    _scrollController.offset -
                                        screenWidth * 0.75,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: kGray700,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _scrollController.animateTo(
                                    _scrollController.offset +
                                        screenWidth * 0.75,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                },
                              ),
                            ),*/,
                          ],
                        ),
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const ProductAllScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_ios, size: 16),
                            label: const Text('EXPLORE TODAS AS COLEÇÕES'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryAppColor,
                              foregroundColor: kFontColorWhite,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                                vertical: 15.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              elevation: 0,
                              textStyle: normalStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
