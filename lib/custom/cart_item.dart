// cart_item.dart
import 'package:pizza_repository/pizza_repository.dart';

class CartItem {
  final Pizza pizzaItem;
  double quantity;

  CartItem({
    required this.pizzaItem,
    this.quantity = 1,
  });

  double get totalPrice => pizzaItem.price * quantity;
}
