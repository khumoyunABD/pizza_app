import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/constants/constants.dart';
import 'package:pizza_app/constants/size_config.dart';
import 'package:pizza_app/custom/cart_repository.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder(
      future: getCartItems(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return Center(
            child: Text(
              'No items added!',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          );
        }

        List<Map<String, dynamic>> cartItems = snapshot.data!;
        double totalPrice = calculateTotalPrice(cartItems);

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getRelativeHeight(0.01),
          ),
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Allow the Column to take up minimum vertical space
            children: [
              // List of cart items
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cartItems[index]['foodName']),
                      subtitle: Text(
                          '${cartItems[index]['quantity']} x ${cartItems[index]['price']} SUM'),
                      trailing: Text(
                          '${cartItems[index]['quantity'] * cartItems[index]['price']} SUM'),
                    );
                  },
                ),
              ),
              const Divider(),
              // Total Price

              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getRelativeHeight(0.01),
                  horizontal: getRelativeHeight(0.02),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price: ',
                      style: TextStyle(
                        fontSize: getRelativeWidth(0.05),
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      '${formatPriceWithDots(totalPrice)} SUM',
                      style: TextStyle(
                        fontSize: getRelativeWidth(0.05),
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
