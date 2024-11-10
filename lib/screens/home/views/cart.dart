// cart_screen.dart
import 'package:flutter/material.dart';
import 'package:pizza_app/custom/cart_provider.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) {
                final item = cart.items.values.toList()[i];
                return CartItemWidget(
                  id: item.pizzaItem.pizzaId,
                  name: item.pizzaItem.name,
                  price: item.pizzaItem.price.toDouble(),
                  quantity: item.quantity.toInt(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// cart_item_widget.dart
class CartItemWidget extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final int quantity;

  const CartItemWidget({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$$price'),
              ),
            ),
          ),
          title: Text(name),
          subtitle: Text('Total: \$${(price * quantity).toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .decreaseQuantity(id);
                },
              ),
              Text('$quantity'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).addItem(
                    Pizza(
                      pizzaId: id,
                      name: name,
                      price: price.toInt(),
                      description: '',
                      picture: '',
                      discount: 0,
                      isVeg: false,
                      macros:
                          Macros(calories: 0, proteins: 0, fat: 0, carbs: 0),
                      spicy: 0,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
