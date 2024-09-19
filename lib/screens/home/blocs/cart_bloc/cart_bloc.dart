// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pizza_app/screens/home/blocs/cart_bloc/cart_event.dart';
// import 'package:pizza_app/screens/home/blocs/cart_bloc/cart_state.dart';
// import 'package:user_repository/user_repository.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   final FirebaseUserRepo _firebaseUserRepo;
//   List<CartItem> cartItems = [];

//   CartBloc(this._firebaseUserRepo) : super(CartInitial()) {
//     on<CartItemsUpdated>(_onCartItemsUpdated);
//     on<AddItem>(_onAddItem);
//     on<RemoveItem>(_onRemoveItem);
//   }

//   double _calculateTotalPrice() {
//     return cartItems.fold(
//         0, (total, item) => total + (item.pricePerUnit * item.quantity));
//   }

//   // Handle adding items to the cart
//   void _onAddItem(AddItem event, Emitter<CartState> emit) {
//     final itemIndex =
//         cartItems.indexWhere((item) => item.name == event.item.name);

//     if (itemIndex != -1) {
//       // Increase quantity if item (pizza) already exists
//       cartItems[itemIndex].quantity += 1;
//     } else {
//       // Add new pizza to the cart
//       cartItems.add(event.item);
//     }

//     emit(CartLoading());
//     try {
//       _firebaseUserRepo.updateCartItemsInFirestore(cartItems);
//       emit(CartSuccess(cartItems, _calculateTotalPrice()));
//     } catch (error) {
//       emit(CartFailure(error.toString()));
//     }
//   }

//   // Handle removing items from the cart
//   void _onRemoveItem(RemoveItem event, Emitter<CartState> emit) {
//     final itemIndex =
//         cartItems.indexWhere((item) => item.name == event.item.name);

//     if (itemIndex != -1 && cartItems[itemIndex].quantity > 1) {
//       // Decrease quantity if there is more than 1 of the pizza
//       cartItems[itemIndex].quantity -= 1;
//     } else {
//       // Remove the item (pizza) from the cart if the quantity is 1 or less
//       cartItems.removeWhere((item) => item.name == event.item.name);
//     }

//     emit(CartLoading());
//     try {
//       _firebaseUserRepo.updateCartItemsInFirestore(cartItems);
//       emit(CartSuccess(cartItems, _calculateTotalPrice()));
//     } catch (error) {
//       emit(CartFailure(error.toString()));
//     }
//   }

//   // Handle updating the cart in Firestore
//   Future<void> _onCartItemsUpdated(
//       CartItemsUpdated event, Emitter<CartState> emit) async {
//     emit(CartLoading());
//     try {
//       await _firebaseUserRepo.updateCartItemsInFirestore(event.cartItems);
//       emit(CartSuccess(cartItems, _calculateTotalPrice()));
//     } catch (error) {
//       emit(CartFailure(error.toString()));
//     }
//   }
// }
