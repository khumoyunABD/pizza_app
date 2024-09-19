import 'package:intl/intl.dart';

String formatPriceWithDots(double price) {
  final formatter = NumberFormat(
      "#,###", "en_US"); // This will format with commas for thousands
  return formatter
      .format(price)
      .replaceAll(',', '.'); // Replace commas with dots
}
