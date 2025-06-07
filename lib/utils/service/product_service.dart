// lib/utils/service/product_service.dart
import 'package:loja/utils/api/Api_Service.dart';
import 'package:loja/utils/post/post_model.dart';

class ProductService extends ApiService {
  static Future<ApiResponse<List<PostModel>>> getProducts({
    String? category,
  }) async {
    String url = "https://fakestoreapi.com/products";
    if (category != null && category.isNotEmpty && category != 'Todas') {
      url = "https://fakestoreapi.com/products/category/$category";
    }
    var response = await ApiService.request<List<PostModel>>(
      url: url,
      verb: HttpVerb.get,
      fromJson: (json) {
        if (json is List) {
          return json
              .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
        return [];
      },
    );
    return response;
  }

  static Future<ApiResponse<List<String>>> getAllCategories() async {
    const url = "https://fakestoreapi.com/products/categories";
    var response = await ApiService.request<List<String>>(
      url: url,
      verb: HttpVerb.get,
      fromJson: (json) {
        if (json is List) {
          return json.map((item) => item.toString()).toList();
        }
        return [];
      },
    );
    return response;
  }
}
