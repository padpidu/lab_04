/// A simple order: one item, a quantity and a price per item.
class Order {
  const Order({
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
  });

  final String itemName;
  final int quantity;
  final double unitPrice; // price of ONE item in RM

  /// Total price = quantity x unit price.
  double get orderTotal => quantity * unitPrice;
}
