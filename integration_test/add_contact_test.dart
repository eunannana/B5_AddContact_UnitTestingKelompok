import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/add_contact.dart';
import 'package:hahahaha/contact_list.dart'; // Sesuaikan dengan path yang benar
import 'package:hahahaha/db_manager.dart';

void main() {
  testWidgets('AddContact widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: AddContact()));

    // Fill in the form fields with some values
    await tester.enterText(find.byType(TextFormField).at(0), 'John');
    await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
    await tester.enterText(find.byType(TextFormField).at(2), '1234567890');
    await tester.enterText(find.byType(TextFormField).at(3), 'john.doe@example.com');

    // Tap the "Save" button.
    await tester.tap(find.text('Save'), warnIfMissed: false);

    // Ensure that the tapped widget is visible on the screen.
    await tester.ensureVisible(find.text('Save'));

    // Wait for the widget to rebuild.
    await tester.pump();

    // Verify that the Navigator pushed to the expected route (ContactList).
    expect(find.byType(ContactList), findsOneWidget);

    // Verify that the database has two entries (one dummy and one user input).
    final dbHelper = DatabaseHelper.instance;
    final allRows = await dbHelper.queryAllRows();
    expect(allRows.length, 2);

    // Optionally, you can add more assertions based on your app's behavior.
  });
}
