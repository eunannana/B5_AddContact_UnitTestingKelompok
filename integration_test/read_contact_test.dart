import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/db_manager.dart';
import 'package:hahahaha/contact_list.dart';

void main() {
  testWidgets('ContactList widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: ContactList()));

    // Assuming you have inserted some dummy data for testing.
    final dbHelper = DatabaseHelper.instance;

    // Inserting dummy data directly to the database for testing
    await dbHelper.insertContact({
      DatabaseHelper.columnName: 'DummyName',
      DatabaseHelper.columnLName: 'DummyLastName',
      DatabaseHelper.columnMobile: '9876543210',
      DatabaseHelper.columnEmail: 'dummy@example.com',
      DatabaseHelper.columnCategory: 'DummyCategory',
      DatabaseHelper.columnProfile: null,
    });

    // Wait for the widget to rebuild.
    await tester.pumpAndSettle(); // Use pumpAndSettle to wait for animations

    // Verify that the contact list displays the correct number of contacts.
    expect(find.text('DummyName DummyLastName'), findsOneWidget);

    // Optionally, you can add more assertions based on your app's behavior.
    
    // For example, if you have a list of contacts, you can check the length:
    expect(find.byType(ListTile), findsNWidgets(1));

    // If you have a specific widget that displays the profile image, you can check it:
    expect(find.byType(CircleAvatar), findsOneWidget);
    
    // Add more assertions as needed based on your ContactList widget structure.
  });
}
