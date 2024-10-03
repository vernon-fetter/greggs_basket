import 'package:flutter/material.dart';
import '../models/sausage_roll.dart';

class BasketManager extends ChangeNotifier {
  final List<SausageRoll> _items = [];

  List<SausageRoll> get items => _items;

  // Calculate the total price of all items in the basket
  double get totalPrice =>
      _items.fold(0, (total, item) => total + item.eatOutPrice);

  // Method to add an item to the basket
  void addItem(SausageRoll item) {
    _items.add(item);
    notifyListeners();
  }

  // Clear the basket
  void clearBasket() {
    _items.clear();
    notifyListeners();
  }
}
