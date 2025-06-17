import 'package:loja/utils/db/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:loja/utils/post/post_model.dart';

class FavoriteService {
  static Future<Database> get _database async =>
      await DatabaseConfig().database;

  static Future<List<PostModel>> getFavorites() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return maps.map((e) => PostModel.fromJson(e)).toList();
  }

  static Future<void> addFavorite(PostModel item) async {
    final db = await _database;
    await db.insert(
      'favorites',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<PostModel?> removeFavorite(int productId) async {
    final db = await _database;
    final maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [productId],
    );
    PostModel? removed;
    if (maps.isNotEmpty) {
      removed = PostModel.fromJson(maps.first);
      await db.delete('favorites', where: 'id = ?', whereArgs: [productId]);
    }
    return removed;
  }

  static Future<bool> isFavorite(int productId) async {
    final db = await _database;
    final maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [productId],
    );
    return maps.isNotEmpty;
  }
}
