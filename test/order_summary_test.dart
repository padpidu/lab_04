import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_04/order.dart';
import 'package:lab_04/order_summary.dart';

void main() {
  testWidgets('Order summary shows correct text and total', (tester) async {
    // 2 x RM 12.50 = RM 25.00
    const order = Order(itemName: 'Cheese Pizza', quantity: 2, unitPrice: 12.50);

    await tester.pumpWidget(
      const MaterialApp(home: OrderSummaryScreen(order: order)),
    );

    expect(find.text('Item: Cheese Pizza'), findsOneWidget);
    expect(find.text('Quantity: 2'), findsOneWidget);
    expect(find.text('Total: RM 25.00'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });
}
