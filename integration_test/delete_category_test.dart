import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/db_manager.dart';
import 'package:hahahaha/homepage.dart';

void main() {
  testWidgets('Delete Category Integration Test', (WidgetTester tester) async {
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

    // Assuming you have a delete button in your UI, find and tap it.
    await tester.tap(find.byIcon(Icons.delete));

    // Wait for the widget to rebuild.
    await tester.pumpAndSettle();

    // Verify that the category list no longer displays the deleted category.
    expect(find.text('TestCategory'), findsNothing);

    // Optionally, you can add more assertions based on your app's behavior.
  });
}
