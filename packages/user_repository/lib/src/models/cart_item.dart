// import 'package:user_repository/src/entities/entities.dart';

// class CartItem {
//   String name;
//   int quantity;
//   double pricePerUnit;
//   String imageUrl; // Assuming each pizza has an image

//   CartItem({
//     required this.name,
//     required this.quantity,
//     required this.pricePerUnit,
//     required this.imageUrl,
//   });

//   static final empty = CartItem(
//     name: '',
//     quantity: 0,
//     pricePerUnit: 0,
//     imageUrl: '',
//   );

//   CartEntity toEntity() {
//     return CartEntity(
//       name: name,
//       quantity: quantity,
//       pricePerUnit: pricePerUnit,
//       imageUrl: imageUrl,
//     );
//   }

//   static CartItem fromEntity(CartEntity entity) {
//     return CartItem(
//       name: entity.name,
//       quantity: entity.quantity,
//       pricePerUnit: entity.pricePerUnit,
//       imageUrl: entity.imageUrl,
//     );
//   }

//   @override
//   String toString() {
//     return 'Cart: $name, $quantity, $pricePerUnit, $imageUrl';
//   }
// }
