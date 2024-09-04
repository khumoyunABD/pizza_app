import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/components/pizza_item.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:pizza_app/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //cart animation
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: getRelativeHeight(0.05),
      width: getRelativeWidth(0.05),
      opacity: 0.7,
      dragAnimation: const DragToCartAnimationOptions(rotation: false),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Row(
            children: [
              Image.asset('assets/8.png', scale: 14),
              const SizedBox(width: 8),
              const Text(
                'PIZZA',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ],
          ),
          actions: [
            //  Adding 'clear-cart-button'
            IconButton(
              icon: const Icon(CupertinoIcons.clear),
              onPressed: () {
                _cartQuantityItems = 0;
                cartKey.currentState!.runClearCartAnimation();
              },
            ),
            AddToCartIcon(
              key: cartKey,
              icon: const Icon(CupertinoIcons.shopping_cart),
              badgeOptions: const BadgeOptions(
                active: true,
                backgroundColor: Colors.red,
              ),
              // onPressed: () {
              //   Navigator.of(context).push(
              //     MaterialPageRoute<void>(
              //       builder: (BuildContext context) => const CartScreen(),
              //     ),
              //   );
              // },
            ),
            IconButton(
                onPressed: () {
                  context.read<SignInBloc>().add(SignOutRequired());
                },
                icon: const Icon(CupertinoIcons.arrow_right_to_line)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<GetPizzaBloc, GetPizzaState>(
            builder: (context, state) {
              if (state is GetPizzaSuccess) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 9 / 16,
                    ),
                    itemCount: state.pizzas.length,
                    itemBuilder: (context, int i) {
                      return PizzaItem(
                        pizza: state.pizzas[i],
                        onClick: itemClick,
                      );
                    });
              } else if (state is GetPizzaLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
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
  }

  void itemClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }
}
