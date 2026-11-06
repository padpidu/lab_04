import 'package:flutter/material.dart';

// Brand colours used across the whole app, defined once.
const Color kOrange = Color(0xFFF57C00);
const Color kCream = Color(0xFFFFF8F0);
const Color kBrown = Color(0xFF3E2723);
const Color kLightOrange = Color(0xFFFFE0B2);

/// Everything we know about one item on the menu.
/// Both the menu screen and the detail screens read from this,
/// so the name, price and description are written in only one place.
class FoodItem {
  const FoodItem({
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.prepTime,
    required this.badge,
    required this.routeName,
    required this.imagePath,
    required this.icon,
  });

  final String name;
  final String tagline; // short line shown on the menu card
  final String description; // longer text shown on the detail screen
  final double price; // price in RM, as a number so we can add it up
  final String prepTime;
  final String badge;
  final String routeName;
  final String imagePath;
  final IconData icon;

  /// The price as text, e.g. 12.5 becomes "RM 12.50".
  String get priceLabel => 'RM ${price.toStringAsFixed(2)}';
}

const FoodItem vegetablePizza = FoodItem(
  name: 'Vegetable Pizza',
  tagline: 'Fresh veggies, light and tasty',
  description: 'A fresh pizza topped with peppers, mushrooms and onions.',
  price: 13.90,
  prepTime: '15 min',
  badge: 'Vegetarian',
  routeName: '/vegetable',
  imagePath: 'assets/images/vegetable.png',
  icon: Icons.eco,
);

const FoodItem cheesePizza = FoodItem(
  name: 'Cheese Pizza',
  tagline: 'Our classic, extra cheesy',
  description: 'A classic pizza with melted mozzarella and tomato sauce.',
  price: 12.50,
  prepTime: '15 min',
  badge: 'Best seller',
  routeName: '/cheese',
  imagePath: 'assets/images/cheese.png',
  icon: Icons.local_pizza,
);

const FoodItem boxOfFries = FoodItem(
  name: 'Box of Fries',
  tagline: 'Hot, golden and crispy',
  description: 'Crispy golden fries, lightly salted.',
  price: 6.90,
  prepTime: '8 min',
  badge: 'Side dish',
  routeName: '/fries',
  imagePath: 'assets/images/fries.png',
  icon: Icons.fastfood,
);

/// The menu, in the order it is shown on screen.
const List<FoodItem> menuItems = [vegetablePizza, cheesePizza, boxOfFries];