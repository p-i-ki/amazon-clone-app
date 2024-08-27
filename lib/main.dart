import 'package:amazone_clone_by_rivaan/common/widgets/bottom_bar.dart';
import 'package:amazone_clone_by_rivaan/constants/golbal_variables.dart';
import 'package:amazone_clone_by_rivaan/features/admin/screens/admin_screen.dart';
import 'package:amazone_clone_by_rivaan/features/auth/screens/auth_screen.dart';
import 'package:amazone_clone_by_rivaan/features/auth/services/auth_service.dart';
import 'package:amazone_clone_by_rivaan/features/home/screens/home_screen.dart';
import 'package:amazone_clone_by_rivaan/provider/user_provider.dart';
import 'package:amazone_clone_by_rivaan/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter/scheduler.dart';

void main() {
  runApp(MultiProvider(providers: [
    //for providing user data across the app
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();
  // @override
  // void initState() {
  //   super.initState();
  //   authService.getUserData(context);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazone Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          //here we can't pass a gradient color, so we have to do it manually.
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
      //     ? Provider.of<UserProvider>(context).user.type == 'user'
      //         ? const BottomBar()
      //         : const AdminScreen()
      //     : const AuthScreen(),
      //home: const BottomBar(),
      home: const AdminScreen(),
    );
  }
}
