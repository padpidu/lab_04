import 'package:flutter/material.dart';

import 'menu_data.dart';

/// One reusable layout for all three detail screens:
/// item name, an image, and a short description (plus price and info).
class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.item});

  final FoodItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      // AppBar automatically shows a back button when this screen
      // was opened with Navigator.pushNamed.
      appBar: AppBar(
        backgroundColor: kOrange,
        foregroundColor: Colors.white,
        title: Text(item.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Large rounded photo with a soft shadow.
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                height: 260,
                width: double.infinity,
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                  // If the picture file is missing, show a friendly
                  // orange placeholder instead of crashing.
                  errorBuilder: (context, error, stack) => Container(
                    color: kLightOrange,
                    child: Icon(item.icon, size: 96, color: kOrange),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: kBrown,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: kOrange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.priceLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _InfoPill(icon: Icons.star, label: item.badge),
              _InfoPill(icon: Icons.timer, label: item.prepTime),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'About this item',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kBrown,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: const TextStyle(fontSize: 16, height: 1.5, color: kBrown),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 52,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: kBrown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to menu'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small rounded label with an icon, e.g. "Vegetarian" or "15 min".
class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: kLightOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: kOrange),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: kBrown)),
        ],
      ),
    );
  }
}

// The three detail screens. Each one just hands its own item
// to the shared layout above.
class VegetableScreen extends StatelessWidget {
  const VegetableScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const ItemDetailScreen(item: vegetablePizza);
}

class CheeseScreen extends StatelessWidget {
  const CheeseScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const ItemDetailScreen(item: cheesePizza);
}

class FriesScreen extends StatelessWidget {
  const FriesScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const ItemDetailScreen(item: boxOfFries);
}