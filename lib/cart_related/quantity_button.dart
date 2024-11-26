// quantity_control_button.dart
import 'package:flutter/material.dart';
import 'package:pizza_app/cart_related/cart_provider.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:provider/provider.dart';

class QuantityControlButton extends StatelessWidget {
  final Pizza pizza;

  const QuantityControlButton({
    super.key,
    required this.pizza,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final cartItem = cart.items[pizza.pizzaId];
        final quantity = cartItem?.quantity ?? 0;

        if (quantity == 0) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              context.read<CartProvider>().addItem(pizza);
            },
            child: const Text('Add'),
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  context.read<CartProvider>().decreaseQuantity(pizza.pizzaId);
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  context.read<CartProvider>().addItem(pizza);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
