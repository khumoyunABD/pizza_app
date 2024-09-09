import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/constants/size_config.dart';
import 'package:pizza_app/screens/home/blocs/cart_bloc/cart_bloc.dart';
import 'package:pizza_app/screens/home/views/details.dart';
import 'package:pizza_repository/pizza_repository.dart';

class PizzaItem extends StatelessWidget {
  PizzaItem({
    super.key,
    required this.pizza,
    required this.onClick,
  });

  final Pizza pizza;
  final void Function(GlobalKey) onClick;
  final GlobalKey widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      elevation: 5, shadowColor: theme.shadowColor,
      //color: Colors.grey.shade100,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => DetailsScreen(pizza),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  key: widgetKey,
                  // color: theme.secondaryHeaderColor,
                  child: Image.network(
                    pizza.picture,
                    fit: BoxFit.cover,
                    height: getRelativeHeight(0.21),
                    width: double.infinity,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Container(
                          padding: EdgeInsets.all(getRelativeWidth(0.03)),
                          height: getRelativeHeight(0.21),
                          width: double.infinity,
                          //color: theme.secondaryHeaderColor,
                          child: CircularProgressIndicator.adaptive(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        height: getRelativeHeight(0.21),
                        width: double.infinity,
                        //color: theme.secondaryHeaderColor,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.redAccent,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.03)),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: pizza.isVeg ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getRelativeHeight(0.004),
                        horizontal: getRelativeWidth(0.02),
                      ),
                      child: Text(
                        pizza.isVeg ? "VEG" : "NON-VEG",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getRelativeWidth(0.02),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getRelativeHeight(0.004),
                        horizontal: getRelativeWidth(0.02),
                      ),
                      child: Text(
                        pizza.spicy == 1
                            ? "🌶️ BLAND"
                            : pizza.spicy == 2
                                ? "🌶️ BALANCE"
                                : "🌶️ SPICY",
                        style: TextStyle(
                            color: pizza.spicy == 1
                                ? Colors.green
                                : pizza.spicy == 2
                                    ? Colors.orange
                                    : Colors.redAccent,
                            fontWeight: FontWeight.w800,
                            fontSize: getRelativeWidth(0.024)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: getRelativeHeight(0.01)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.03)),
              child: Text(
                pizza.name,
                style: TextStyle(
                    fontSize: getRelativeWidth(0.05),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(0.03), // Responsive padding
              ),
              child: Text(
                pizza.description,
                style: TextStyle(
                  fontSize: getRelativeWidth(0.03),
                  color: Colors.grey.shade500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(0.03), // Responsive padding
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${pizza.price - (pizza.price * (pizza.discount) / 100).round()} sum",
                            style: TextStyle(
                              fontSize: getRelativeWidth(0.035),
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: getRelativeWidth(0.015),
                          ),
                          Text(
                            "${pizza.price} sum",
                            style: TextStyle(
                              fontSize: getRelativeWidth(0.027),
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //custom button
            SizedBox(
              height: getRelativeHeight(0.008),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(0.02),
              ),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state.itemCounter == 0) {
                    return SizedBox(
                      height: getRelativeHeight(0.03),
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          onClick(widgetKey);
                          context.read<CartBloc>().add(AddItemEvent());
                        },
                        icon: Icon(
                          CupertinoIcons.add,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        label: Text(
                          'Add',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        style: ElevatedButton.styleFrom(
                          // Adjust the vertical padding if needed
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    );
                  } else if (state.itemCounter > 0) {
                    return Container(
                      color: theme.cardColor,
                      height: getRelativeHeight(0.032),
                      width: getRelativeWidth(0.4),
                      // decoration: BoxDecoration(
                      //   border: Border.all(width: 2),
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(RemoveItemEvent());
                            },
                            icon: Icon(
                              CupertinoIcons.minus,
                              size: getRelativeHeight(0.02),
                              // color: theme.primaryColor,
                            ),
                          ),
                          Text(state.itemCounter.toString()),
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(AddItemEvent());
                            },
                            icon: Icon(
                              CupertinoIcons.plus,
                              size: getRelativeHeight(0.02),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox(
                    height: getRelativeHeight(0.03),
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => onClick(widgetKey),
                      icon: Icon(
                        CupertinoIcons.add,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      label: Text(
                        'Add',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      style: ElevatedButton.styleFrom(
                        // Adjust the vertical padding if needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
