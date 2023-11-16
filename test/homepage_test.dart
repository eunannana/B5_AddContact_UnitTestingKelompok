import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/homepage.dart';

void main() {
  testWidgets('HomePage Widget Test', (WidgetTester tester) async {
    // Build app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );
    // Verify if the app bar title is present
    expect(find.text("create and store category"), findsOneWidget);
    // Verify if the "Save" button is present
    expect(find.text("Save"), findsOneWidget);
    // Simulate tapping on the "Save" button
    await tester.tap(find.text("Save"));
    await tester.pump();
    // Verify that the form validation error message is displayed
    expect(find.text('Enter category name'), findsOneWidget);
    // Enter text in the TextFormField
    await tester.enterText(find.byType(TextFormField), 'Test Category');
    // Verify that the entered text is displayed
    expect(find.text('Test Category'), findsOneWidget);
    // Simulate tapping on the "Save" button again
    await tester.tap(find.text("Save"));
    await tester.pump();
    // Verify that the category is added to the list
    expect(find.text('Test Category'), findsOneWidget);
  });
}
