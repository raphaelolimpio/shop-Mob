// lib/screens/products/products_screen.dart (ProductsScreen agora é a Home/Timeline)
import 'package:flutter/material.dart';
import 'package:loja/DS/components/appBar/appBar_custom.dart';
import 'package:loja/DS/components/cards/card_Custom/custom_card_view_model.dart';
import 'package:loja/DS/components/cards/enum/card_enums.dart';
import 'package:loja/DS/components/cards/listCard/list_card_custom.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';
import 'package:loja/screens/Product_all_screen.dart';
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

  @override
  void initState() {
    super.initState();
    _productsFuture = Service.getPosts();
  }

  List<CustomCardViewModel> _mapPostsToCardViewModels(List<PostModel> posts) {
    return posts.map((post) {
      return CustomCardViewModel(
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
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth * 0.45;
    final itemPadding = 8.0;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomAppBar(brandName: "Loja"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .stretch, // Estica a coluna para preencher a largura
          children: [
            // --- Seção da História da Marca (com imagem de fundo e overlay) ---
            Container(
              height:
                  MediaQuery.of(context).size.height *
                  0.6, // Ocupa uma % da altura da tela
              decoration: BoxDecoration(
                color: kDeepNavyBlue1, // Cor de fundo se não houver imagem
                // Exemplo com imagem de fundo, como no D&G
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/history.png',
                  ), // Adicione esta imagem
                  fit: BoxFit.cover,
                  // Ajuste a opacidade para que o texto seja legível
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
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center, // Centraliza conteúdo verticalmente
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start, // Alinha texto à esquerda como D&G
                  children: [
                    Text(
                      historyTitle,
                      style: headingStyle.copyWith(
                        fontSize: 28,
                        color: kElegantGold4, // Título em dourado
                        fontWeight: FontWeight.bold,
                        letterSpacing:
                            1.2, // Um pouco de espaçamento para o título
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Na nossa loja,não vendemos apenas produtos; oferecemos as peças que completam a sua narrativa.\n\n"
                      "Imagine-se: cada roupa que você veste não é só tecido, mas uma declaração de quem você é, criada para realçar sua confiança e autenticidade em cada passo da sua jornada.\n\n"
                      "Pense nos dispositivos que o acompanham: não são apenas circuitos, mas as ferramentas que conectam você ao mundo, à sua paixão, à sua próxima grande ideia, amplificando cada experiência.\n\n"
                      "E sinta o toque das joias: elas não são meros adornos, mas elos preciosos que celebram seus momentos únicos, irradiando a sua essência e a sua história mais íntima.\n\n"
                      "Acreditamos que o extraordinário está nos detalhes, na qualidade que inspira e na experiência que permanece. Aqui, cada escolha é um passo em direção à sua melhor versão, onde estilo, inovação e emoção se encontram para criar algo verdadeiramente seu.",
                      textAlign: TextAlign.left, // Alinhado à esquerda como D&G
                      style: normalStyle.copyWith(
                        fontSize: 15, // Ligeiramente menor para caber melhor
                        color: kSoftCream1, // Texto em tom creme suave
                        height: 1.4, // Espaçamento entre linhas
                      ),
                      maxLines: 10, // Limite de linhas para a história
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment:
                          Alignment.centerLeft, // Alinha o botão à esquerda
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
                            borderRadius: BorderRadius.circular(
                              5,
                            ), // Bordas menos arredondadas
                          ),
                          elevation: 0, // Sem sombra para um visual mais plano
                          textStyle: normalStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 0.8, // Espaçamento entre letras
                          ),
                        ),
                        child: const Text(
                          'CONHEÇA NOSSA FILOSOFIA',
                        ), // Texto em maiúsculas
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40), // Espaçamento generoso entre seções
            // --- Seção de Produtos - "Coleções Criadas Para Você" ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ), // Padding lateral maior
              child: Text(
                'COLEÇÕES CRIADAS PARA VOCÊ', // Título em maiúsculas
                style: sectionHeadingStyle.copyWith(
                  fontSize: 22,
                  color: kDeepNavyBlue2,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 20), // Espaçamento

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
                        products.take(5).toList();

                    final List<CustomCardViewModel> cardViewModels =
                        _mapPostsToCardViewModels(featuredProducts);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ajuste para o ListCard horizontal
                        SizedBox(
                          height:
                              420, // Aumente a altura para acomodar cards maiores e imagem
                          child: ListCard(
                            cards: cardViewModels,
                            cardModelType: CardModelType.customCard,
                            displayMode: CardDisplayMode.horizontalScroll,
                          ),
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
