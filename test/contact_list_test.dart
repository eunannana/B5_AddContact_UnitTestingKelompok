import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/contact_list.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Delete contact triggers deletion method',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ContactList(),
      ),
    );
    // Wait for any animations or state changes to complete
    await tester.pumpAndSettle();

    // Check if there is at least one contact in the list
    if (find.byType(ListTile).evaluate().isNotEmpty) {
      // Tap the delete button of the first contact
      await tester.tap(find.byIcon(Icons.delete).first);

      // Wait for any animations or state changes to complete
      await tester.pumpAndSettle();

      // Verify that the contact is deleted
      expect(find.byType(ListTile), findsNothing);
    } else {
      // Handle the case when the list is empty, or take appropriate action
      print('No contacts found to delete.');
    }
  });
}
