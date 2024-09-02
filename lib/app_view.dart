import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app/screens/auth/views/welcome.dart';
import 'package:pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:pizza_app/screens/home/views/home.dart';
import 'package:pizza_app/screens/home/views/splash.dart';
import 'package:pizza_repository/pizza_repository.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _startSplashTimer();
  }

  void _startSplashTimer() {
    Timer(const Duration(seconds: 4, milliseconds: 300), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return const Directionality(
        textDirection: TextDirection.ltr, // or TextDirection.rtl if needed
        child: SplashScreen(),
      );
    }
    return MaterialApp(
        title: 'Pizza Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.light(
                surface: Colors.grey.shade200,
                onSurface: Colors.black,
                primary: Colors.blue,
                onPrimary: Colors.white)),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SignInBloc(
                        context.read<AuthenticationBloc>().userRepository),
                  ),
                  BlocProvider(
                    create: (context) =>
                        GetPizzaBloc(FirebasePizzaRepo())..add(GetPizza()),
                  ),
                ],
                child: const HomeScreen(),
              );
            } else {
              return const WelcomeScreen();
            }
          }),
        ),);
  }
}
