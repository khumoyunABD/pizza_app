import 'package:flutter/material.dart';
import 'package:pizza_app/constants/size_config.dart';
import 'package:shimmer/shimmer.dart';

//shimmering skeleton constants
const Color baseColor = Color(0xFF616161);
const Color highlightColor = Color(0xFF9E9E9E);

Widget pizzaItemAddShimmer = Shimmer.fromColors(
  baseColor: baseColor,
  highlightColor: highlightColor,
  child: Container(
    height: getRelativeHeight(0.02),
    width: double.infinity,
    //margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey[700],
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
