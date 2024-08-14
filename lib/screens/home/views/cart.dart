import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            Text(
              'Your Cart',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
            ),
            SizedBox(
              width: 15,
            ),
            Icon(CupertinoIcons.cart_fill),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Your cart is empty...',
          style: TextStyle(
            color: Theme.of(context).colorScheme.surfaceTint,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}