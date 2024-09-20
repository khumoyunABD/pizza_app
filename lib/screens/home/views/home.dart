import 'dart:developer';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/components/pizza_item.dart';
import 'package:pizza_app/custom/cart_repository.dart';
import 'package:pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //cart animation
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  //final _cartQuantityItems = 0;

  @override
  Widget build(BuildContext context) {
    // AddToCartAnimation(
    //   cartKey: cartKey,
    //   height: getRelativeHeight(0.05),
    //   width: getRelativeWidth(0.05),
    //   opacity: 0.7,
    //   dragAnimation: const DragToCartAnimationOptions(rotation: false),
    //   jumpAnimation: const JumpAnimationOptions(),
    //   createAddToCartAnimation: (runAddToCartAnimation) {
    //     this.runAddToCartAnimation = runAddToCartAnimation;
    //   },

    //color: Theme.of(context).colorScheme.surface,
    // appBar: AppBar(
    //   backgroundColor: Theme.of(context).colorScheme.surface,
    //   title: Row(
    //     children: [
    //       Image.asset('assets/8.png', scale: 14),
    //       const SizedBox(width: 8),
    //       const Text(
    //         'PIZZA',
    //         style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
    //       ),
    //     ],
    //   ),
    //   actions: [
    //     //  Adding 'clear-cart-button'
    //     IconButton(
    //       icon: const Icon(CupertinoIcons.clear),
    //       onPressed: () {
    //         _cartQuantityItems = 0;
    //         cartKey.currentState!.runClearCartAnimation();
    //       },
    //     ),
    //     AddToCartIcon(
    //       key: cartKey,
    //       icon: const Icon(CupertinoIcons.shopping_cart),
    //       badgeOptions: const BadgeOptions(
    //         active: true,
    //         //_cartQuantityItems == 0 ? false : true,
    //         backgroundColor: Colors.red,
    //       ),
    //       // onPressed: () {
    //       //   Navigator.of(context).push(
    //       //     MaterialPageRoute<void>(
    //       //       builder: (BuildContext context) => const CartScreen(),
    //       //     ),
    //       //   );
    //       // },
    //     ),
    //     IconButton(
    //         onPressed: () {
    //           context.read<SignInBloc>().add(SignOutRequired());
    //         },
    //         icon: const Icon(CupertinoIcons.arrow_right_to_line)),
    //   ],
    // ),
    final ThemeData theme = Theme.of(context);
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Material(
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          right: 16,
          left: 16,
          bottom: 16,
        ),
        child: BlocBuilder<GetPizzaBloc, GetPizzaState>(
          builder: (context, state) {
            if (state is GetPizzaSuccess) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 9 / 16,
                  ),
                  itemCount: state.pizzas.length,
                  itemBuilder: (context, int i) {
                    return PizzaItem(
                      pizza: state.pizzas[i],
                      itemIndex: i,
                      onAddToCart:
                          (foodId, foodName, price, foodPicture) async {
                        // Fetch pizza details
                        var pizzaId = state.pizzas[i].pizzaId;
                        var pizzaName = state.pizzas[i].name;
                        var pizzaPrice = state.pizzas[i].price;
                        var pizzaPicture = state.pizzas[i].picture;

                        // Await the addToCart function
                        try {
                          await addToCart(
                            userId,
                            pizzaId,
                            pizzaName,
                            pizzaPrice.toDouble(),
                            pizzaPicture,
                          );
                          log('$pizzaName was added to cart!');
                        } catch (e) {
                          log('Failed to add pizza to cart!');
                        }
                      },
                    );
                  });
            } else if (state is GetPizzaLoading) {
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
    );
    // );
  }

  // void addItem(GlobalKey widgetKey) async {
  //   await runAddToCartAnimation(widgetKey);
  //   await cartKey.currentState!
  //       .runCartAnimation((++_cartQuantityItems).toString());
  // }
}
