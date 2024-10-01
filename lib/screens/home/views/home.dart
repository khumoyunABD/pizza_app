import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/components/pizza_item.dart';
import 'package:pizza_app/custom/bloc/cart_bloc.dart';
import 'package:pizza_app/custom/bloc/cart_state.dart';
import 'package:pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //cart animation
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        //color: theme.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            right: 16,
            left: 16,
            bottom: 16,
          ),
          child: BlocBuilder<GetPizzaBloc, GetPizzaState>(
            builder: (context, pizzaState) {
              if (pizzaState is GetPizzaSuccess) {
                return BlocBuilder<CartBloc, CartState>(
                  builder: (context, cartState) {
                    if (cartState is CartLoaded) {
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 9 / 16,
                          ),
                          itemCount: pizzaState.pizzas.length,
                          itemBuilder: (context, int i) {
                            // Find if the pizza exists in the cart
                            final cartItem = cartState.cartItems.firstWhere(
                              (item) =>
                                  item['foodId'] ==
                                  pizzaState.pizzas[i].pizzaId,
                              orElse: () => {},
                            );
                            return PizzaItem(
                              pizza: pizzaState.pizzas[i],
                              //cartItem: cartItem,
                            );
                          });
                    }
                    return const SizedBox();
                  },
                );
              } else if (pizzaState is GetPizzaLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                return const Center(
                  child: Text("An error has occured..."),
                );
              }
            },
          ),
        ),
      ),
    );
    // );
  }
}
