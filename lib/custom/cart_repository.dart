import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addToCart(
    String userId, String foodId, String foodName, double price) async {
  final cartItemRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('cart')
      .doc(foodId);

  DocumentSnapshot cartItem = await cartItemRef.get();

  if (cartItem.exists) {
    // If the item is already in the cart, update the quantity
    cartItemRef.update({
      'quantity': FieldValue.increment(1),
      'price': price,
    });
    log('Cart updated');
  } else {
    // Add a new item to the cart
    cartItemRef.set({
      'foodName': foodName,
      'price': price,
      'quantity': 1,
    });
    log('Cart added');
  }
}

Future<List<Map<String, dynamic>>> getCartItems(String userId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('cart')
      .get();

  List<Map<String, dynamic>> cartItems = snapshot.docs.map((doc) {
    return {
      'foodName': doc['foodName'],
      'price': doc['price'],
      'quantity': doc['quantity'],
    };
  }).toList();

  return cartItems;
}

double calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
  double total = 0.0;
  for (var item in cartItems) {
    total += item['price'] * item['quantity'];
  }
  return total;
}

Future<void> removeFromCart(String userId, String foodId) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('cart')
      .doc(foodId)
      .delete();
}
