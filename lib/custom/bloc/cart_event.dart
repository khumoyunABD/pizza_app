import 'package:equatable/equatable.dart';

// Define all the events for Cart
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

// Event to add an item to the cart
class AddToCartEvent extends CartEvent {
  final String userId;
  final String foodId;
  final String foodName;
  final double price;
  final String foodPicture;

  const AddToCartEvent(
      this.userId, this.foodId, this.foodName, this.price, this.foodPicture);

  @override
  List<Object?> get props => [userId, foodId, foodName, price, foodPicture];
}

// Event to remove an item from the cart
class RemoveFromCartEvent extends CartEvent {
  final String userId;
  final String foodId;

  const RemoveFromCartEvent(this.userId, this.foodId);

  @override
  List<Object?> get props => [userId, foodId];
}

// Event to load the cart items
class LoadCartEvent extends CartEvent {
  final String userId;

  const LoadCartEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
