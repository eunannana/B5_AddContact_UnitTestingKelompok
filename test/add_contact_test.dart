import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/add_contact.dart';
import 'package:flutter/material.dart';

void main() {
  group('AddContact Widget Test', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: AddContact(),
        ),
      );

      // Verify that the widget displays the necessary components.
      expect(find.text('Add Contact'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(DropdownButton<String>), findsOneWidget);
    });

    testWidgets('Submitting form triggers insert method', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: AddContact(),
        ),
      );

      // Fill in the form
      await tester.enterText(find.byKey(const Key('firstNameField')), 'John');
      await tester.enterText(find.byKey(const Key('lastNameField')), 'Doe');
      await tester.enterText(find.byKey(const Key('mobileNumberField')), '123456789');
      await tester.enterText(find.byKey(const Key('emailAddressField')), 'john@example.com');

      // Select an item in the dropdown
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Category 1')); 
      await tester.pumpAndSettle();

      // Tap the save button
      await tester.tap(find.text('Save'));

      // Wait for any animations or state changes to complete
      await tester.pumpAndSettle();

      // Verify that the save operation is successful
      expect(find.text('Saved successfully!'), findsOneWidget);
    });
  });
}
