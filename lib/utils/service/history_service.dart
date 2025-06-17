import 'package:sqflite/sqflite.dart';
import 'package:loja/utils/post/post_model.dart';
import 'package:loja/utils/db/db.dart';

class HistoryService {
  static Future<Database> get _database async {
    return await DatabaseConfig().database;
  }

  static Future<void> addItemsToHistory(List<PostModel> items) async {
    final db = await _database;
    final batch = db.batch();

    for (var item in items) {
      batch.insert('history_items', {
        'productId': item.id,
        'title': item.title,
        'image': item.image,
        'price': item.price,
        'category': item.category,
        'description': item.description,
        'purchaseDate': DateTime.now().toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  static Future<List<PostModel>> getPurchaseHistory() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query(
      'history_items',
      orderBy: 'purchaseDate DESC',
    );

    return List.generate(maps.length, (i) {
      return PostModel(
        id: maps[i]['productId'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        category: maps[i]['category'],
        image: maps[i]['image'],
      );
    });
  }

  static Future<void> clearHistory() async {
    final db = await _database;
    await db.delete('history_items');
  }
}
