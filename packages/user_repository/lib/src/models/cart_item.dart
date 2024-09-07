import 'package:user_repository/src/entities/entities.dart';

class CartItem {
  String pizzaName;
  int quantity;
  double pricePerUnit;

  CartItem({
    required this.pizzaName,
    required this.quantity,
    required this.pricePerUnit,
  });

  static final empty = CartItem(
    pizzaName: '',
    quantity: 0,
    pricePerUnit: 0,
  );

  CartEntity toEntity() {
    return CartEntity(
      pizzaName: pizzaName,
      quantity: quantity,
      pricePerUnit: pricePerUnit,
    );
  }

  static CartItem fromEntity(CartEntity entity) {
    return CartItem(
      pizzaName: entity.pizzaName,
      quantity: entity.quantity,
      pricePerUnit: entity.pricePerUnit,
    );
  }

  @override
  String toString() {
    return 'Cart: $pizzaName, $quantity, $pricePerUnit';
  }
}
