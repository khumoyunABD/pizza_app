import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/constants/constants.dart';
import 'package:pizza_app/constants/size_config.dart';
import 'package:pizza_app/custom/bloc/cart_bloc.dart';
import 'package:pizza_app/custom/bloc/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // final String userId = FirebaseAuth.instance.currentUser!.uid;
    // Future fetchCartItems = getCartItems(userId);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          //future: fetchCartItems,
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartEmpty) {
              return Center(
                child: Text(
                  'No items added!',
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              );
            } else if (state is CartError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else if (state is CartLoaded) {
              double totalPrice = state.totalPrice;

              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getRelativeHeight(0.01),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = state.cartItems[index];

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getRelativeWidth(0.02),
                              vertical: getRelativeHeight(0.01),
                            ),
                            child: Row(
                              children: [
                                Material(
                                  color: theme.colorScheme.secondaryContainer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Image.network(
                                    height: getRelativeHeight(0.1),
                                    width: getRelativeWidth(0.2),
                                    item['foodPicture'].toString(),
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: getRelativeWidth(0.05),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['foodName'],
                                        style: TextStyle(
                                          fontSize: getRelativeWidth(0.045),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getRelativeHeight(0.006),
                                      ),
                                      Text(
                                        '${formatPriceWithDots(item['price'])} SUM',
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: getRelativeWidth(0.04),
                                ),
                                Container(
                                  height: getRelativeHeight(0.05),
                                  width: getRelativeWidth(0.28),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.secondary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(14)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text('${item['quantity']}'),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  _buildBottomNavigationBar(
                      context, theme, totalPrice), // Accessing totalPrice here
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, ThemeData theme, double totalPrice) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getRelativeWidth(0.03),
        vertical: getRelativeHeight(0.01),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(0.03),
                vertical: getRelativeHeight(0.015),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.directions_walk,
                        size: getRelativeHeight(0.024),
                        color: theme.colorScheme.onSurface,
                      ),
                      SizedBox(
                        width: getRelativeWidth(0.2),
                      ),
                      Text(
                        'Delivery SUM 4500',
                        style: TextStyle(
                          fontSize: getRelativeWidth(0.036),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: getRelativeHeight(0.02),
                    color: theme.colorScheme.onSurface,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size(
                  getRelativeWidth(0.8),
                  getRelativeHeight(0.06),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                backgroundColor: theme.indicatorColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '20-30 min',
                    style: TextStyle(
                      fontSize: getRelativeWidth(0.035),
                      color: theme.colorScheme.surface,
                    ),
                  ),
                  Text(
                    'Next',
                    style: TextStyle(
                      fontSize: getRelativeWidth(0.04),
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.surface,
                    ),
                  ),
                  Text(
                    '${formatPriceWithDots(totalPrice)} SUM', // Display total price
                    style: TextStyle(
                      fontSize: getRelativeWidth(0.035),
                      fontWeight: FontWeight.w400,
                      color: theme.colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
