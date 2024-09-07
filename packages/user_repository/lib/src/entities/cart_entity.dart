class CartEntity {
  String pizzaName;
  int quantity;
  double pricePerUnit;

  CartEntity({
    required this.pizzaName,
    required this.quantity,
    required this.pricePerUnit,
  });

  Map<String, Object?> toDocument() {
    return {
      'pizzaName': pizzaName,
      'quantity': quantity,
      'pricePerUnit': pricePerUnit,
    };
  }

  static CartEntity fromDocument(Map<String, dynamic> doc) {
    return CartEntity(
      pizzaName: doc['pizzaName'],
      quantity: doc['quantity'],
      pricePerUnit: doc['pricePerUnit'],
    );
  }
}
