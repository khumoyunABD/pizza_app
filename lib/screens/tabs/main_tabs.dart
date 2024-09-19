import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_app/components/app_fader_effect.dart';
import 'package:pizza_app/components/bnb.dart';
import 'package:pizza_app/screens/home/views/cart.dart';
import 'package:pizza_app/screens/home/views/home.dart';
import 'package:pizza_app/screens/tabs/order.dart';
import 'package:pizza_app/screens/tabs/profile.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  late final ScrollController _scrollController;
  bool _atBottom = false;
  // final bool _isShimmerActive = true;

  //custom added
  int _selectedIndex = 0; // To track the selected tab

  final List<Widget> _pages = [
    const ProfileScreen(), // Profile screen
    const OrderScreen(), // Document screen
    const CartScreen(), // Bag screen
    const HomeScreen(), // Home screen
  ];

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Scroll Listener
  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _atBottom = true;
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _atBottom = false;
      });
    }
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _atBottom = false;
      });
    }
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      /// AppBar
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/8.png', scale: 14),
            const SizedBox(width: 8),
            const Text(
              'PIZZA_RAY',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       context.read<SignInBloc>().add(SignOutRequired());
        //     },
        //     icon: const Icon(CupertinoIcons.arrow_right_to_line),
        //   ),
        // ],
      ),
      //_appBar(context),
      extendBody: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: SizedBox.expand(
          child: Stack(
            children: [
              /// Application Body
              // _lisView(),

              //custom
              _pages[_selectedIndex],

              /// Fader Effect
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AppFaderEffect(atBottom: _atBottom),
              ),

              /// Bottom Navigation Bar
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: AppBBN(atBottom: _atBottom),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBBN(
        atBottom: _atBottom,
        onTabSelected: _onTabSelected,
      ),
    );
  }

  /// Application Body - ListView
  // Positioned _lisView() {
  //   return Positioned.fill(
  //     child: ListView.builder(
  //       physics: const ClampingScrollPhysics(),
  //       controller: _scrollController,
  //       itemCount: 9,
  //       itemBuilder: (context, index) {
  //         return _buildSingleItem(context);
  //       },
  //     ),
  //   );
  // }

  /// AppBar
  // AppBar _appBar(BuildContext context) {
  //   return AppBar(
  //     centerTitle: true,
  //     title: Animate(
  //       effects: [
  //         !_atBottom ? const BlurEffect() : const MoveEffect(),
  //       ],
  //       child: Column(
  //         children: [
  //           Text(
  //             "Don't forget to SUBSCRIBE!",
  //             style: TextStyle(
  //               color: Theme.of(context).primaryColor,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 2,
  //           ),
  //           Animate(
  //             effects: [_atBottom ? const ScaleEffect() : const MoveEffect()],
  //             child: Text(
  //               "@PROGRAMMINGWIHTFLEXZ",
  //               style: TextStyle(
  //                 backgroundColor: !_atBottom ? null : Colors.red,
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 15,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildSingleItem(BuildContext context) {
  //   var baseColor = Theme.of(context).colorScheme.secondary;
  //   var highlightColor = Theme.of(context).dialogBackgroundColor;
  //   return Column(
  //     children: [
  //       SizedBox(
  //         width: double.infinity,
  //         height: 110,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                   flex: 2,
  //                   child: Shimmer.fromColors(
  //                     baseColor: baseColor,
  //                     highlightColor: highlightColor,
  //                     enabled: _isShimmerActive,
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         color: Colors.grey.shade900,
  //                         borderRadius: BorderRadius.circular(
  //                           20,
  //                         ),
  //                       ),
  //                     ),
  //                   )),
  //               Expanded(
  //                 flex: 5,
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 20),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Shimmer.fromColors(
  //                         baseColor: baseColor,
  //                         highlightColor: highlightColor,
  //                         enabled: _isShimmerActive,
  //                         child: Container(
  //                           width: 400,
  //                           height: 20,
  //                           decoration: BoxDecoration(
  //                               color: Colors.black,
  //                               borderRadius: BorderRadius.circular(10)),
  //                         ),
  //                       ),
  //                       const SizedBox(
  //                         height: 6,
  //                       ),
  //                       Shimmer.fromColors(
  //                         baseColor: baseColor,
  //                         highlightColor: highlightColor,
  //                         enabled: _isShimmerActive,
  //                         child: Container(
  //                           width: 200,
  //                           height: 12,
  //                           decoration: BoxDecoration(
  //                               color: Colors.black,
  //                               borderRadius: BorderRadius.circular(10)),
  //                         ),
  //                       ),
  //                       const SizedBox(
  //                         height: 6,
  //                       ),
  //                       Shimmer.fromColors(
  //                         baseColor: baseColor,
  //                         highlightColor: highlightColor,
  //                         enabled: _isShimmerActive,
  //                         child: Container(
  //                           width: 90,
  //                           height: 12,
  //                           decoration: BoxDecoration(
  //                               color: Colors.black,
  //                               borderRadius: BorderRadius.circular(10)),
  //                         ),
  //                       ),
  //                       const SizedBox(
  //                         height: 6,
  //                       ),
  //                       Shimmer.fromColors(
  //                         baseColor: baseColor,
  //                         highlightColor: highlightColor,
  //                         enabled: _isShimmerActive,
  //                         child: Container(
  //                           width: 120,
  //                           height: 12,
  //                           decoration: BoxDecoration(
  //                               color: Colors.black,
  //                               borderRadius: BorderRadius.circular(10)),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 24),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Row(
  //                               crossAxisAlignment: CrossAxisAlignment.end,
  //                               mainAxisAlignment: MainAxisAlignment.end,
  //                               children: [
  //                                 Shimmer.fromColors(
  //                                   baseColor: baseColor,
  //                                   highlightColor: highlightColor,
  //                                   enabled: _isShimmerActive,
  //                                   child: Container(
  //                                     width: 60,
  //                                     height: 12,
  //                                     decoration: BoxDecoration(
  //                                         color: Colors.black,
  //                                         borderRadius:
  //                                             BorderRadius.circular(10)),
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   width: 10,
  //                                 ),
  //                                 Shimmer.fromColors(
  //                                   baseColor: baseColor,
  //                                   highlightColor: highlightColor,
  //                                   enabled: _isShimmerActive,
  //                                   child: Container(
  //                                     width: 40,
  //                                     height: 12,
  //                                     decoration: BoxDecoration(
  //                                         color: Colors.black,
  //                                         borderRadius:
  //                                             BorderRadius.circular(10)),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Shimmer.fromColors(
  //                               baseColor: baseColor,
  //                               highlightColor: highlightColor,
  //                               enabled: _isShimmerActive,
  //                               child: Container(
  //                                 width: 12,
  //                                 height: 12,
  //                                 decoration: BoxDecoration(
  //                                     color: Colors.black,
  //                                     borderRadius: BorderRadius.circular(10)),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 20,
  //       ),
  //     ],
  //   );
  // }
}
