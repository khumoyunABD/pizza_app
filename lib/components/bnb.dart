import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';

class AppBBN extends StatelessWidget {
  const AppBBN({
    super.key,
    required bool atBottom,
    required this.onTabSelected,
  }) : _atBottom = atBottom;

  final bool _atBottom;
  final ValueChanged<int>
      onTabSelected; // Callback to notify when a tab is selected

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return NavigationView(
      onChangePage: onTabSelected,
      curve: Curves.fastEaseInToSlowEaseOut,
      durationAnimation: const Duration(milliseconds: 400),
      backgroundColor: theme.scaffoldBackgroundColor,
      borderTopColor: Theme.of(context).brightness == Brightness.light
          ? _atBottom
              ? theme.primaryColor
              : null
          : null,
      color: theme.primaryColor,
      items: [
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.profile,
              color: theme.primaryColor,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.profile,
              color: theme.dialogBackgroundColor,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.document,
              color: theme.primaryColor,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.document,
              color: theme.dialogBackgroundColor,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.bag,
              color: theme.primaryColor,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.bag,
              color: theme.dialogBackgroundColor,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              Ionicons.fast_food,
              //FontAwesomeIcons.utensils,
              color: theme.primaryColor,
              size: 35,
            ),
            childBefore: Icon(
              Ionicons.fast_food_outline,
              //FontAwesomeIcons.utensils,
              color: theme.dialogBackgroundColor,
              size: 30,
            )),
      ],
    );
  }
}
