import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/models.dart';

class MyUser {
  String userId;
  String email;
  String name;
  bool hasActiveCart;
  List<CartItem>? cartItems;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
    this.cartItems,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
    name: '',
    hasActiveCart: false,
    // cartItems: List.empty(),
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      hasActiveCart: hasActiveCart,
      cart: cartItems,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      hasActiveCart: entity.hasActiveCart,
      cartItems: entity.cart,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $hasActiveCart, $cartItems';
  }
}
