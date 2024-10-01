import 'package:equatable/equatable.dart';

// Define all the possible states for Cart
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

// Initial state
class CartInitial extends CartState {}

// Loading state
class CartLoading extends CartState {}

// Loaded state with cart items
class CartLoaded extends CartState {
  final List<Map<String, dynamic>> cartItems;
  final double totalPrice;

  const CartLoaded(this.cartItems, this.totalPrice);

  @override
  List<Object?> get props => [cartItems, totalPrice];
}

// Cart is empty
class CartEmpty extends CartState {}

// Error state
class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
