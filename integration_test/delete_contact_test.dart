import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/contact_list.dart';

void main() {
  testWidgets('Delete contact test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: ContactList(),
    ));

    // Verify that the contact list is displayed.
    expect(find.byType(ContactList), findsOneWidget);

    // Assuming there is at least one item in the list
    // Get the first delete button in the list
    final deleteButton = find.byIcon(Icons.delete).first;

    // Tap the delete button and trigger a frame.
    await tester.tap(deleteButton);
    await tester.pump();

    // Verify that the item is deleted from the list
    expect(find.byIcon(Icons.delete), findsNothing);
  });
}