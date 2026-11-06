import 'package:flutter/material.dart';

import 'menu_data.dart';

/// StatefulWidget because the screen has something that changes:
/// how many of each item the customer has added.
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // How many of each item has been added, e.g. {cheesePizza: 2}.
  final Map<FoodItem, int> _quantities = {};

  int _quantityOf(FoodItem item) => _quantities[item] ?? 0;

  int get _totalCount =>
      _quantities.values.fold(0, (sum, quantity) => sum + quantity);

  double get _totalPrice => _quantities.entries
      .fold(0.0, (sum, entry) => sum + entry.key.price * entry.value);

  // setState tells Flutter "something changed, redraw the screen".
  void _add(FoodItem item) {
    setState(() => _quantities[item] = _quantityOf(item) + 1);
  }

  void _remove(FoodItem item) {
    setState(() {
      final newQuantity = _quantityOf(item) - 1;
      if (newQuantity <= 0) {
        _quantities.remove(item);
      } else {
        _quantities[item] = newQuantity;
      }
    });
  }

  void _clear() {
    setState(() => _quantities.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      appBar: AppBar(
        backgroundColor: kOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Pizza Store Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _PromoBanner(),
          const SizedBox(height: 24),
          const Text(
            'Our Menu',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: kBrown,
            ),
          ),
          const SizedBox(height: 12),
          for (final item in menuItems)
            MenuCard(
              item: item,
              quantity: _quantityOf(item),
              onAdd: () => _add(item),
              onRemove: () => _remove(item),
            ),
        ],
      ),
      bottomNavigationBar: _TotalBar(
        count: _totalCount,
        total: _totalPrice,
        onClear: _clear,
      ),
    );
  }
}

/// Dark banner at the top, like a shop's welcome sign.
class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kBrown,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.local_pizza, color: kLightOrange, size: 48),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fresh from the oven',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Baked to order. Ready in about 15 minutes.',
                  style: TextStyle(color: kLightOrange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// One orange card: picture, name, price and a + / - to build the order.
/// Tapping the card itself opens the item's named route
/// using Navigator.pushNamed (as the lab requires).
class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  final FoodItem item;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: kOrange,
        elevation: 4,
        shadowColor: const Color(0x66000000),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.pushNamed(context, item.routeName),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // The picture. Shows an icon if the file is missing.
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    item.imagePath,
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      width: 88,
                      height: 88,
                      color: Colors.white,
                      child: Icon(item.icon, color: kOrange, size: 40),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.tagline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color(0xFFFFF3E0)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.priceLabel,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // + button, and (once something is added) the count and -.
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filled(
                      tooltip: 'Add ${item.name}',
                      onPressed: onAdd,
                      icon: const Icon(Icons.add),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: kOrange,
                      ),
                    ),
                    if (quantity > 0) ...[
                      Text(
                        'x$quantity',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Remove one ${item.name}',
                        onPressed: onRemove,
                        icon: const Icon(Icons.remove_circle_outline),
                        color: Colors.white,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bar fixed at the bottom of the screen showing the running total.
class _TotalBar extends StatelessWidget {
  const _TotalBar({
    required this.count,
    required this.total,
    required this.onClear,
  });

  final int count;
  final double total;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBrown,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      count == 1 ? 'Your order: 1 item' : 'Your order: $count items',
                      style: const TextStyle(color: kLightOrange),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Total: RM ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: count > 0 ? onClear : null,
                child: const Text('Clear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}