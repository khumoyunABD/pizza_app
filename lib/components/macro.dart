import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMacroWidget extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;

  const MyMacroWidget(
      {required this.title,
      required this.value,
      required this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: theme.shadowColor,
                offset: const Offset(2, 2),
                blurRadius: 5)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FaIcon(
              icon,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 4),
            Text(
              title == "Calories" ? '$value $title' : '${value}g $title',
              style: TextStyle(
                fontSize: 10,
                color: theme.colorScheme.onSurface,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
