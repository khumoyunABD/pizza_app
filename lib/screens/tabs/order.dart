import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_app/constants/size_config.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Order Screen",
            style: TextStyle(
              fontSize: getRelativeWidth(0.06),
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(
            height: getRelativeHeight(0.015),
          ),
          Icon(
            FontAwesomeIcons.fileInvoiceDollar,
            color: theme.primaryColor,
          ),
        ],
      ),
    );
  }
}