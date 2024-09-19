class MyUserEntity {
  String userId;
  String email;
  String name;
  bool hasActiveCart;
  //List<CartItem>? cart;

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
    //this.cart,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'hasActiveCart': hasActiveCart,
      //'cart': cart?.map((item) => item.toEntity().toDocument()),
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
      hasActiveCart: doc['hasActiveCart'],
      //cart: doc['cart']
      //    ?.map((item) => CartItem.fromEntity(CartEntity.fromDocument(item))),
    );
  }
}
