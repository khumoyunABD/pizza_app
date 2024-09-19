// class CartEntity {
//   String name;
//   int quantity;
//   double pricePerUnit;
//   String imageUrl; // Assuming each pizza has an image

//   CartEntity({
//     required this.name,
//     required this.quantity,
//     required this.pricePerUnit,
//     required this.imageUrl,
//   });

//   Map<String, Object?> toDocument() {
//     return {
//       'name': name,
//       'quantity': quantity,
//       'pricePerUnit': pricePerUnit,
//       'imageUrl': imageUrl,
//     };
//   }

//   static CartEntity fromDocument(Map<String, dynamic> doc) {
//     return CartEntity(
//       name: doc['name'],
//       quantity: doc['quantity'],
//       pricePerUnit: doc['pricePerUnit'],
//       imageUrl: doc['imageUrl'],
//     );
//   }
// }
