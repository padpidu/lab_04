import 'package:flutter/material.dart';

import 'detail_screens.dart';
import 'menu_screen.dart';

void main() {
  runApp(const PizzaStoreApp());
}

class PizzaStoreApp extends StatelessWidget {
  const PizzaStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      // The screen shown when the app starts.
      initialRoute: '/menu',
      // The 4 named routes: a route name (String) mapped to a screen.
      routes: {
        '/menu': (context) => const MenuScreen(),
        '/vegetable': (context) => const VegetableScreen(),
        '/cheese': (context) => const CheeseScreen(),
        '/fries': (context) => const FriesScreen(),
      },
    );
  }
}
