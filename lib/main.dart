import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/app.dart';
import 'package:pizza_app/constants/simple_bloc_observer.dart';
import 'package:pizza_app/cart_related/cart_provider.dart';
import 'package:pizza_app/firebase_options.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  // Initialize CartProvider
  final cartProvider = CartProvider();
  await cartProvider.init();

  runApp(MyApp(
    userRepository: FirebaseUserRepo(),
    cartProvider: cartProvider,
  ));
}
