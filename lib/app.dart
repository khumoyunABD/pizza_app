import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/app_view.dart';
import 'package:pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza_app/cart_related/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final CartProvider cartProvider;

  const MyApp({
    required this.userRepository,
    required this.cartProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(userRepository: userRepository),
        ),
        RepositoryProvider<FirebaseUserRepo>(
          create: (context) => FirebaseUserRepo(),
        ),
        // ChangeNotifier providers
        ChangeNotifierProvider.value(
          value: cartProvider,
        ),
      ],
      child: const MyAppView(),
    );
  }
}
