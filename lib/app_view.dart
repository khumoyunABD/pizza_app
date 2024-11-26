import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza_app/config/app_theme.dart';
import 'package:pizza_app/constants/size_config.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app/screens/auth/views/welcome.dart';
import 'package:pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:pizza_app/screens/shared/splash.dart';
import 'package:pizza_app/screens/tabs/main_tabs.dart';
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
    _startSplashTimerOnIsolate();
  }

  // Function that runs on a separate isolate
  static Future<void> _startSplashTimer(Null _) async {
    await Future.delayed(const Duration(seconds: 4, milliseconds: 300));
  }

  // Start splash timer on a separate isolate using compute
  void _startSplashTimerOnIsolate() async {
    await compute(_startSplashTimer, null); // Use compute to run the delay
    if (mounted) {
      setState(() {
        _showSplash = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (_showSplash) {
      return const Directionality(
        textDirection: TextDirection.ltr, // or TextDirection.rtl if needed
        child: SplashScreen(),
      );
    }
    return MaterialApp(
      title: 'Pizza Delivery',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
          //setting responsive size
          SizeConfig.initSize(context);

          if (state.status == AuthenticationStatus.unknown) {
            // While the authentication status is being determined, show a loading indicator
            return const Material(
                child: Center(child: CircularProgressIndicator.adaptive()));
          } else if (state.status == AuthenticationStatus.authenticated) {
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
                // BlocProvider(
                //   create: (context) =>
                //       CartBloc()..add(LoadCartEvent(user?.uid)),
                // ),
              ],
              child: const MainTabs(),
            );
          } else {
            return const WelcomeScreen();
          }
        }),
      ),
    );
  }
}
