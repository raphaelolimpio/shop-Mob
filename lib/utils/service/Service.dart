import 'package:loja/utils/api/Api_Service.dart';
import 'package:loja/utils/post/post_model.dart';

class Service {
  static Future<ApiResponse<List<PostModel>>> getPosts() async {
    var url = "https://fakestoreapi.com/products";

    var response = await ApiService.request<List<PostModel>>(
      url: url,
      verb: HttpVerb.get,
      fromJson:
          (json) =>
              (json as List)
                  .map(
                    (item) => PostModel.fromJson(item as Map<String, dynamic>),
                  )
                  .toList(),
    );
    if (response.statusCode >= 200 || response.statusCode < 300) {
      print("Numero de posts ${response.data!.length}");

      for (PostModel post in response.data!) {
        print(post);
      }
    } else {
      print("ERRO DE COMUNICACAO");
    }

    return response;
  }
}
