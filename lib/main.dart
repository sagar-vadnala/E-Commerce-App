import 'package:e_commerce_app/cart/cart.dart';
import 'package:e_commerce_app/conts/global_colors.dart';
import 'package:e_commerce_app/login/login_screen.dart';
import 'package:e_commerce_app/provider/auth-provider.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/screens/categories_screen.dart';
import 'package:e_commerce_app/screens/feeds_screen.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(), // Wrap CategoriesPage with the MultiProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rest Api',
      theme: ThemeData(
        scaffoldBackgroundColor: lightScaffoldColor,
        primaryColor: lightCardColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: lightIconsColor,
          ),
          backgroundColor: lightScaffoldColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: lightTextColor, fontSize: 22, fontWeight: FontWeight.bold),
          elevation: 0,
        ),
        iconTheme: IconThemeData(
          color: lightIconsColor,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.blue,
        ),
        cardColor: lightCardColor,
        brightness: Brightness.light,
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(
              secondary: lightIconsColor,
              brightness: Brightness.light,
            )
            .copyWith(background: lightBackgroundColor),
      ),
      // home: HomeScreen(),
      initialRoute: '/home',
      routes: {
        // '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/all_products': (context) => const FeedsScreen(),
        '/categories': (context) => const CategoriesScreen(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
