import 'package:flutter/material.dart';
import 'package:loja/DS/components/appBar/appBar_custom.dart';
import 'package:loja/DS/components/loading/loading.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';
import 'package:loja/utils/post/post_model.dart';
import 'package:loja/utils/service/history_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<PostModel>> _historyFuture;

  @override
  void initState() {
    super.initState();
    Loading(color: kBlueColor);
    _fetchHistory();
  }

  void _fetchHistory() {
    setState(() {
      _historyFuture = HistoryService.getPurchaseHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomAppBar(brandName: "Loja"),
      drawer: buildAppDrawer(context),
      body: FutureBuilder<List<PostModel>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Nenhuma compra encontrada no histórico.',

                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: kGray600),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma compra encontrada no histórico.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: kGray600),
              ),
            );
          } else {
            final List<PostModel> historyItems = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                final item = historyItems[index];
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
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
