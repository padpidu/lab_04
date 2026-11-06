import 'package:flutter_test/flutter_test.dart';
import 'package:lab_04/main.dart';

void main() {
  testWidgets('Menu lists the three items', (tester) async {
    await tester.pumpWidget(const PizzaStoreApp());

    expect(find.text('Vegetable Pizza'), findsOneWidget);
    expect(find.text('Cheese Pizza'), findsOneWidget);
    expect(find.text('Box of Fries'), findsOneWidget);
  });

  testWidgets('Tapping a card opens its detail screen', (tester) async {
    await tester.pumpWidget(const PizzaStoreApp());

    await tester.tap(find.text('Cheese Pizza'));
    await tester.pumpAndSettle(); // wait for the page animation

    // Detail screen shows the name and its description.
    expect(find.text('Cheese Pizza'), findsWidgets);
    expect(
      find.text('A classic pizza with melted mozzarella and tomato sauce.'),
      findsOneWidget,
    );
    // The menu title is no longer the active screen's AppBar.
    expect(find.text('Pizza Store Menu'), findsNothing);
  });

  testWidgets('Back button returns to the menu', (tester) async {
    await tester.pumpWidget(const PizzaStoreApp());

    await tester.tap(find.text('Box of Fries'));
    await tester.pumpAndSettle();

    await tester.pageBack(); // taps the AppBar back button
    await tester.pumpAndSettle();

    expect(find.text('Pizza Store Menu'), findsOneWidget);
    expect(find.text('Vegetable Pizza'), findsOneWidget);
  });
}
