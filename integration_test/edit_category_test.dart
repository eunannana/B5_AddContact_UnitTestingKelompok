import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/db_manager.dart';
import 'package:hahahaha/homepage.dart';

void main() {
  testWidgets('Edit Category Integration Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Assuming you have inserted some dummy data for testing.
    final dbHelper = DatabaseHelper.instance;

    // Inserting dummy data directly to the database for testing
    await dbHelper.insert({
      DatabaseHelper.columnName: 'TestCategory',
    });

    // Wait for the widget to rebuild.
    await tester.pumpAndSettle();

    // Verify that the category list displays the correct number of categories.
    expect(find.text('TestCategory'), findsOneWidget);

    // Find and tap the edit button.
    await tester.tap(find.byIcon(Icons.edit));

    // Wait for the widget to rebuild.
    await tester.pumpAndSettle();

    // Verify that the edit screen is displayed (adjust this according to your app's behavior).
    expect(find.text('Edit Category'), findsOneWidget);

    // Assuming you have a TextFormField for editing the category name,
    // find it and enter a new category name.
    await tester.enterText(find.byType(TextFormField), 'EditedCategory');

    // Find and tap the save button.
    await tester.tap(find.text('Save'));

    // Wait for the widget to rebuild.
    await tester.pumpAndSettle();

    // Verify that the category list displays the edited category name.
    expect(find.text('EditedCategory'), findsOneWidget);

    // Optionally, you can add more assertions based on your app's behavior.
  });
}
