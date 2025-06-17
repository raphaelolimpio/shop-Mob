import 'package:loja/utils/db/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:loja/utils/post/post_model.dart';

class CartService {
  static Future<Database> get _database async =>
      await DatabaseConfig().database;

  static Future<List<PostModel>> getCartItems() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('wallet');
    return maps.map((e) => PostModel.fromJson(e)).toList();
  }

  static Future<void> addToCart(PostModel item) async {
    final db = await _database;
    await db.insert(
      'wallet',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<PostModel?> removeFromCart(int productId) async {
    final db = await _database;
    final maps = await db.query(
      'wallet',
      where: 'id = ?',
      whereArgs: [productId],
    );
    PostModel? removed;
    if (maps.isNotEmpty) {
      removed = PostModel.fromJson(maps.first);
      await db.delete('wallet', where: 'id = ?', whereArgs: [productId]);
    }
    return removed;
  }

  static Future<bool> isInCart(int productId) async {
    final db = await _database;
    final maps = await db.query(
      'wallet',
      where: 'id = ?',
      whereArgs: [productId],
    );
    return maps.isNotEmpty;
  }

  static Future<void> clearCart() async {
    final db = await _database;
    await db.delete('wallet');
  }
}
