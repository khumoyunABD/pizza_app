import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pizza_app/cart_related/cart_item.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  static const String cartKey = 'cart_data';
  SharedPreferences? _prefs;
  bool _initialized = false;

  CartProvider();

  Map<String, CartItem> get items => {..._items};
  int get itemCount => _items.length;

  // Add initialization method
  Future<void> init() async {
    if (_initialized) return;
    _prefs = await SharedPreferences.getInstance();
    await _loadCartFromPrefs();
    _initialized = true;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      final discountedPrice = item.pizzaItem.price -
          (item.pizzaItem.price * item.pizzaItem.discount / 100).round();
      total += discountedPrice * item.quantity;
    });
    return total;
  }

  Future<void> _loadCartFromPrefs() async {
    if (_prefs == null) return;

    final String? cartData = _prefs!.getString(cartKey);
    if (cartData != null) {
      try {
        final Map<String, dynamic> decodedData = json.decode(cartData);
        decodedData.forEach((pizzaId, itemData) {
          final Map<String, dynamic> pizzaData = itemData['pizzaItem'];
          final Pizza pizza = Pizza(
            pizzaId: pizzaData['pizzaId'],
            name: pizzaData['name'],
            price: pizzaData['price'],
            discount: pizzaData['discount'],
            // Add other pizza properties as needed
            picture: pizzaData['picture']?.toString() ?? '',
            description: pizzaData['description']?.toString() ?? '',
            isVeg: pizzaData['isVeg'] as bool? ?? false,
            macros: Macros(calories: 0, proteins: 0, fat: 0, carbs: 0),
            spicy: 0,
          );

          _items[pizzaId] = CartItem(
            pizzaItem: pizza,
            quantity: itemData['quantity'],
          );
        });
        notifyListeners();
      } catch (e) {
        log('Error loading cart data: $e');
      }
    }
  }

  Future<void> _saveCartToPrefs() async {
    if (_prefs == null) return;

    try {
      final Map<String, dynamic> cartData = {};
      _items.forEach((pizzaId, cartItem) {
        cartData[pizzaId] = {
          'pizzaItem': {
            'pizzaId': cartItem.pizzaItem.pizzaId,
            'name': cartItem.pizzaItem.name,
            'price': cartItem.pizzaItem.price,
            'discount': cartItem.pizzaItem.discount,
            // Add other pizza properties as needed
          },
          'quantity': cartItem.quantity,
        };
      });

      await _prefs!.setString(cartKey, json.encode(cartData));
    } catch (e) {
      log('Error saving cart data: $e');
    }
  }

  Future<void> addItem(Pizza pizza) async {
    if (_prefs == null) await init();

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
    await _saveCartToPrefs();
    notifyListeners();
  }

  Future<void> removeItem(String pizzaId) async {
    if (_prefs == null) await init();

    _items.remove(pizzaId);
    await _saveCartToPrefs();
    notifyListeners();
  }

  Future<void> decreaseQuantity(String pizzaId) async {
    if (_prefs == null) await init();

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
    await _saveCartToPrefs();
    notifyListeners();
  }

  Future<void> clear() async {
    if (_prefs == null) await init();

    _items.clear();
    await _prefs?.remove(cartKey);
    notifyListeners();
  }
}
