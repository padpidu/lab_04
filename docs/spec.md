# Order Summary Screen - Mini-Spec

- **Inputs:** an `Order` (item name, quantity, unit price) from `lib/order.dart`.
- **Output:** a screen (`lib/order_summary.dart`) showing item name, quantity and total price in RM.
- **Rules:** the total must come from `orderTotal` (quantity x unit price); show 2 decimal places.
- **Rules:** a Back button calls `Navigator.pop`.
- **Out of scope:** payments, editing the order, multiple items, saving data.
- **Check:** an order of 2 x RM 12.50 shows "Total: RM 25.00"; `flutter analyze` and `flutter test` pass.
