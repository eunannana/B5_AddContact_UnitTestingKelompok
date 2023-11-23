import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/models/category.dart';
import 'package:hahahaha/db_manager.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hahahaha/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Read Category Test', () {
    testWidgets(
      'Verify Reading Categories',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Add dummy categories to the list
        final dbHelper = DatabaseHelper.instance;
        await dbHelper.insert({DatabaseHelper.columnName: 'Category 1'});
        await dbHelper.insert({DatabaseHelper.columnName: 'Category 2'});

        await tester.pumpAndSettle();

        // Ensure that the added dummy categories are displayed
        expect(find.text('Category 1'), findsOneWidget);
        expect(find.text('Category 2'), findsOneWidget);

        // Print a message indicating that the test finished
        print('Test Finished: Reading Categories');
      },
    );
  });
}
