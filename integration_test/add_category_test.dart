import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/main.dart' as app; 

void main() {
  testWidgets('Add Category Integration Test', (tester) async {
    app.main();

    // Wait for the app to load
    await tester.pumpAndSettle();

    // Find the text field for adding a category
    final addCategoryTextField = find.byType(TextField);
    expect(addCategoryTextField, findsOneWidget);

    // Enter a category name
    await tester.enterText(addCategoryTextField, 'New Category');

    // Find the save button and tap it
    final saveButton = find.text('Save');
    expect(saveButton, findsOneWidget);
    await tester.tap(saveButton);

    // Wait for the UI to rebuild
    await tester.pumpAndSettle();

    // Verify that the new category is displayed
    final newCategory = find.text('New Category');
    expect(newCategory, findsOneWidget);

  });
}
