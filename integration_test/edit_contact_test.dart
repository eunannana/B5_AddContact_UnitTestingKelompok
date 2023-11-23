import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/db_manager.dart';
import 'package:hahahaha/contact_list.dart';

void main() {
  testWidgets('Edit Contact Integration Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: ContactList()));

    // Assuming you have inserted some dummy data for testing.
    final dbHelper = DatabaseHelper.instance;

    // Inserting dummy data directly to the database for testing
    await dbHelper.insertContact({
      DatabaseHelper.columnName: 'TestName',
      DatabaseHelper.columnLName: 'TestLastName',
      DatabaseHelper.columnMobile: '9876543210',
      DatabaseHelper.columnEmail: 'test@example.com',
      DatabaseHelper.columnCategory: 'TestCategory',
      DatabaseHelper.columnProfile: 'base64encodedimage',
    });

    // Wait for the widget to rebuild.
    await tester.pumpAndSettle();

    // Verify that the contact list displays the correct number of contacts.
    expect(find.text('TestName TestLastName'), findsOneWidget);

    // Find and tap the edit button.
    await tester.tap(find.byIcon(Icons.edit));

    // Wait for the widget to rebuild.
    await tester.pumpAndSettle();

    // Verify that the edit screen is displayed (adjust this according to your app's behavior).
    expect(find.text('Edit Contact'), findsOneWidget);

    // Assuming you have TextFormField widgets for editing contact details,
    // find them and enter new values.
    await tester.enterText(find.byKey(ValueKey('firstNameField')), 'EditedName');
    await tester.enterText(find.byKey(ValueKey('lastNameField')), 'EditedLastName');

    // Find and tap the save button.
    await tester.tap(find.text('Save'));

    // Wait for the widget to rebuild.
    await tester.pumpAndSettle();

    // Verify that the contact list displays the edited contact details.
    expect(find.text('EditedName EditedLastName'), findsOneWidget);

    // Optionally, you can add more assertions based on your app's behavior.
  });
}
