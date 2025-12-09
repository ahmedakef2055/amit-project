import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amit_project/features/auth/auth_service.dart';
import 'package:amit_project/screens/login_screen.dart';
import 'package:amit_project/screens/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/login": (_) => const LoginScreen(),
        "/home": (_) => const HomeScreen(),
      },
    );
  }
}