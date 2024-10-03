import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/sausage_roll.dart';

class StorageService {
  Future<void> saveBasket(List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonItems = items.map((item) {
      final sausageRoll = item['sausageRoll'].toJson();
      return {'sausageRoll': sausageRoll, 'quantity': item['quantity']};
    }).toList();
    prefs.setString('basket', jsonEncode(jsonItems));
  }

  Future<List<Map<String, dynamic>>> loadBasket() async {
    final prefs = await SharedPreferences.getInstance();
    final savedBasket = prefs.getString('basket');
    if (savedBasket != null) {
      final List<dynamic> decodedItems = jsonDecode(savedBasket);
      return decodedItems.map((item) {
        final sausageRoll = SausageRoll.fromJson(item['sausageRoll']);
        return {'sausageRoll': sausageRoll, 'quantity': item['quantity']};
      }).toList();
    }
    return [];
  }
}
