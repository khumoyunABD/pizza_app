import 'package:flutter/material.dart';
import 'package:pizza_app/custom/cart_item.dart';
import 'package:pizza_repository/pizza_repository.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      // Consider the discount in the price calculation
      final discountedPrice = item.pizzaItem.price -
          (item.pizzaItem.price * item.pizzaItem.discount / 100).round();
      total += discountedPrice * item.quantity;
    });
    return total;
  }

  void addItem(Pizza pizza) {
    if (_items.containsKey(pizza.pizzaId)) {
      _items.update(
        pizza.pizzaId,
        (existingItem) => CartItem(
          pizzaItem: existingItem.pizzaItem,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        pizza.pizzaId,
        () => CartItem(pizzaItem: pizza),
      );
    }
    notifyListeners();
  }

  void removeItem(String pizzaId) {
    _items.remove(pizzaId);
    notifyListeners();
  }

  void decreaseQuantity(String pizzaId) {
    if (!_items.containsKey(pizzaId)) return;

    if (_items[pizzaId]!.quantity > 1) {
      _items.update(
        pizzaId,
        (existingItem) => CartItem(
          pizzaItem: existingItem.pizzaItem,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(pizzaId);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
