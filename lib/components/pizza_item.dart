import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/constants/size_config.dart';
import 'package:pizza_app/screens/home/views/details.dart';
import 'package:pizza_repository/pizza_repository.dart';

class PizzaItem extends StatefulWidget {
  const PizzaItem({
    super.key,
    required this.pizza,
    required this.onAddToCart,
    required this.itemIndex,
  });

  final Pizza pizza;
  final void Function(
      String foodId, String foodName, double price, String picture) onAddToCart;

  //final void Function(GlobalKey) onClick;
  final int itemIndex;
  //final GlobalKey widgetKey = GlobalKey();

  @override
  State<PizzaItem> createState() => _PizzaItemState();
}

class _PizzaItemState extends State<PizzaItem> {
  //new cart function
  int quantity = 0;

  // void _addToCart() {
  //   setState(() {
  //     quantity += 1; // Increment the quantity
  //   });
  //   //widget.onClick(widget.widgetKey); // Trigger the onClick to add to cart
  // }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      //elevation: 5,
      shadowColor: theme.shadowColor,
      //color: Colors.grey.shade100,
      color: theme.colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => DetailsScreen(widget.pizza),
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
                child: SizedBox(
                  //key: widget.widgetKey,
                  // color: theme.secondaryHeaderColor,
                  child: Image.network(
                    widget.pizza.picture,
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
                        color: widget.pizza.isVeg ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getRelativeHeight(0.004),
                        horizontal: getRelativeWidth(0.02),
                      ),
                      child: Text(
                        widget.pizza.isVeg ? "VEG" : "NON-VEG",
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
                        widget.pizza.spicy == 1
                            ? "🌶️ BLAND"
                            : widget.pizza.spicy == 2
                                ? "🌶️ BALANCE"
                                : "🌶️ SPICY",
                        style: TextStyle(
                            color: widget.pizza.spicy == 1
                                ? Colors.green
                                : widget.pizza.spicy == 2
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
                widget.pizza.name,
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
                widget.pizza.description,
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
                            "${widget.pizza.price - (widget.pizza.price * (widget.pizza.discount) / 100).round()} sum",
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
                            "${widget.pizza.price} sum",
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
              child: SizedBox(
                height: getRelativeHeight(0.03),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Pass the pizza details to the parent widget's addToCart function
                    widget.onAddToCart(
                      widget.pizza.pizzaId,
                      widget.pizza.name,
                      widget.pizza.price.toDouble(),
                      widget.pizza.picture,
                    );
                    //widget.onClick(widget.widgetKey);
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
              ),
            ),
            if (quantity > 0)
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getRelativeWidth(0.01)),
                child: Text(
                  "Quantity: $quantity",
                  style: TextStyle(
                    fontSize: getRelativeWidth(0.015),
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
