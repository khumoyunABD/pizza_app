import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  // Event handler to load the cart
  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      final cartItems = await getCartItems(event.userId);
      if (cartItems.isEmpty) {
        emit(CartEmpty());
      } else {
        final totalPrice = calculateTotalPrice(cartItems);
        emit(CartLoaded(cartItems, totalPrice));
      }
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }

  // Event handler to add an item to the cart
  Future<void> _onAddToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      await addToCart(event.userId, event.foodId, event.foodName, event.price,
          event.foodPicture);
      add(LoadCartEvent(event.userId)); // Reload the cart after adding an item
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }

  // Event handler to remove an item from the cart
  Future<void> _onRemoveFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    try {
      await removeFromCart(event.userId, event.foodId);
      add(LoadCartEvent(
          event.userId)); // Reload the cart after removing an item
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }

  // Firestore functions moved here for Bloc management
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
        'foodPicture': doc['picture'],
      };
    }).toList();

    return cartItems;
  }

  Future<void> addToCart(String userId, String foodId, String foodName,
      double price, String foodPicture) async {
    final cartItemRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(foodId);

    DocumentSnapshot cartItem = await cartItemRef.get();

    if (cartItem.exists) {
      cartItemRef.update({
        'quantity': FieldValue.increment(1),
        'price': price,
      });
    } else {
      cartItemRef.set({
        'foodName': foodName,
        'price': price,
        'quantity': 1,
        'picture': foodPicture,
      });
    }
  }

  Future<void> removeFromCart(String userId, String foodId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(foodId)
        .delete();
  }

  double calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
    double total = 0.0;
    for (var item in cartItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }
}
