/// main.dart
///
/// This Dart file serves as the entry point for the Flutter application.
/// It defines the `MyApp` class, which is a StatelessWidget representing
/// the root of the application. The main() function is used to run the
/// application by creating an instance of MyApp and rendering it.
///

// Importing necessary packages and files.
import 'package:flutter/material.dart';
import 'package:hahahaha/homepage.dart';

/// The main() function is the entry point for the Flutter application.
void main() {
  // Running the application by creating an instance of MyApp.
  runApp(const MyApp());
}

/// The `MyApp` class is a StatelessWidget representing the root of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Returning MaterialApp widget, which defines the overall app structure.
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Setting the home screen to the `HomePage` widget.
      home: HomePage(),
    );
  }
}
