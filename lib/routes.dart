import 'package:amazone_clone_by_rivaan/common/widgets/bottom_bar.dart';
import 'package:amazone_clone_by_rivaan/features/admin/screens/addproduct_screen.dart';
import 'package:amazone_clone_by_rivaan/features/auth/screens/auth_screen.dart';
import 'package:amazone_clone_by_rivaan/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Page Does Not Exists !!'),
                ),
              ));
  }
}
