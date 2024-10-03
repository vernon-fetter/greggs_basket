import 'package:flutter/material.dart';
import '../models/sausage_roll.dart';
import '../services/storage_service.dart';

class BasketManager extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  final StorageService _storageService;
  bool _isEatIn = false;

  BasketManager(this._storageService) {
    loadBasket();
  }

  List<Map<String, dynamic>> get items => _items;

  bool get isEatIn => _isEatIn;

  double get totalPrice {
    return _items.fold(0, (total, item) {
      double price = _isEatIn ? item['sausageRoll'].eatInPrice : item['sausageRoll'].eatOutPrice;
      return total + (price * item['quantity']);
    });
  }

  void toggleEatIn() {
    _isEatIn = !_isEatIn;
    notifyListeners();
  }

  void addItem(SausageRoll item, int quantity) {
    _items.add({'sausageRoll': item, 'quantity': quantity});
    _storageService.saveBasket(_items);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _storageService.saveBasket(_items);
    notifyListeners();
  }

  void clearBasket() {
    _items.clear();
    _storageService.saveBasket(_items);
    notifyListeners();
  }

  void loadBasket() async {
    List<Map<String, dynamic>> savedItems = await _storageService.loadBasket();
    _items.addAll(savedItems);
    notifyListeners();
  }
}
