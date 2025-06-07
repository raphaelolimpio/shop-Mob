import 'package:flutter/material.dart';
import 'package:loja/utils/post/post_model.dart';
import 'package:loja/utils/service/Service.dart';

class MainScreen extends StatefulWidget {
  String messageTitle = "Statefull Widget";
  String messageDescription = "Este é um WidgetStateFull";
  String messageErrorTitle = "Erro!";
  String messageErrorDescription = "Não foi possível carregar os dados";

  @override
  State<StatefulWidget> createState() {
    return MainsScreenState();
  }
}

//Vai gerenciar os estados e a rendererizacao da cena MainScreen
class MainsScreenState extends State<MainScreen> {
  List<PostModel> posts = [];
  int mainScreenState = 2;
  int countSuccess = 0;

  void changeState() {
    setState(() {
      mainScreenState++;
      mainScreenState %= 3;
    });
  }

  ElevatedButton tryAgain() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          mainScreenState = 2;
        });
        loadData();
      },
      child: Text("Tentar Novamente"),
    );
  }

  // carregDados tem um delay de 3 segundos e recebe um Future<ApiResponse<List<PostModel>>> de TimeLineService
  Future<void> loadData() async {
    //3 segundos de sleep
    await Future.delayed(Duration(seconds: 3));
    final resultado = await Service.getPosts();

    setState(() {
      mainScreenState = 1;
    });
    if (countSuccess < 2) {
      countSuccess++;
      return;
    }
    if (resultado.statusCode >= 200 && resultado.statusCode < 300) {
      setState(() {
        posts = resultado.data!;
        mainScreenState = 0;
      });
    } else {
      setState(() {
        mainScreenState = 1;
      });
    }
    if (countSuccess < 2) {
      countSuccess++;
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    switch (mainScreenState) {
      case 0:
        return successScreen();
      case 1:
        return failureScreen();
      default:
        return loadingScreen();
    }
  }

  Widget successScreen() {
    return Scaffold(
      appBar: AppBar(title: Text(widget.messageTitle)),
      body: GestureDetector(
        onTap: changeState,
        child: Column(
          children: [
            Center(child: Text(widget.messageDescription)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Card(
                    child: ListTile(
                      title: Text(post.title),
                      leading: Image.network(post.image),
                      subtitle: Text(post.category),
                      trailing: Text("\$${post.price.toStringAsFixed(2)}"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Text(post.title),
                                content: Text(post.category),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainScreen(),
                                          ),
                                        ),
                                    child: Text("Ver Post"),
                                  ),
                                ],
                              ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget failureScreen() {
    return Scaffold(
      appBar: AppBar(title: Text(widget.messageErrorTitle)),
      body: GestureDetector(
        onTap: changeState,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(widget.messageErrorDescription)),
            SizedBox(height: 20),
            tryAgain(),
          ],
        ),
      ),
    );
  }

  Widget loadingScreen() {
    return Scaffold(
      appBar: AppBar(title: Text('Carregando...')),
      body: GestureDetector(
        onTap: changeState,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
