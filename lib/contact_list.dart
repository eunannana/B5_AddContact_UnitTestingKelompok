/// contact_list.dart
///
/// This Dart file defines the `ContactList` class, a StatefulWidget that
/// displays a list of contacts. It utilizes a SQLite database for data
/// storage and retrieval. The contact list can be viewed and contacts
/// can be deleted from this screen.
///

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hahahaha/mydrawal.dart';

import 'colors.dart';
import 'db_manager.dart';

/// The `ContactList` class is a StatefulWidget that displays a list of contacts.
class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

/// The `_ContactListState` class is the corresponding State class for the
/// `ContactList` widget.
class _ContactListState extends State<ContactList> {
  // Instance of the DatabaseHelper for interacting with the SQLite database.
  final dbHelper = DatabaseHelper.instance;

  // List to store all contact data retrieved from the database.
  List<Map<String, dynamic>> allCategoryData = [];

  @override
  void initState() {
    super.initState();
    // Initialize the state by querying the database for all contact data.
    _query();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Drawer for additional navigation options.
        drawer: MyDrawal(),
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text("Contact List"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Empty text widget for spacing.
            Text(""),

            // Expanded ListView for displaying the contact list.
            Expanded(
              child: ListView.builder(
                itemCount: allCategoryData.length,
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  var item = allCategoryData[index];
                  // Decoding base64 encoded profile image data.
                  Uint8List bytes = base64Decode(item['profile']);
                  return Container(
                    color: MyColors.orangeTile,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        // Contact information and action buttons.
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            // CircleAvatar displaying the contact's profile picture.
                            CircleAvatar(
                              child: Image.memory(bytes, fit: BoxFit.cover),
                              minRadius: 20,
                              maxRadius: 25,
                            ),
                            // Displaying contact's first and last name.
                            Text("${item['name']}"),
                            Text("${item['lname']}"),
                            Spacer(),
                            // Edit and Delete buttons.
                            IconButton(
                              onPressed: null,
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                _delete(item['_id']);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                        // Divider for separating contacts.
                        const Divider(
                          color: MyColors.orangeDivider,
                          thickness: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Private method to query all rows of contact data from the database.
  void _query() async {
    final allRows = await dbHelper.queryAllRowsofContact();
    print('query all rows:');
    allRows.forEach(print);
    allCategoryData = allRows;
    // Update the UI with the retrieved data.
    setState(() {});
  }

  /// Private method to delete a contact with the specified ID from the database.
  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.deleteContact(id);
    print('deleted $rowsDeleted row(s): row $id');
    // Update the UI with the modified data.
    _query();
  }
}
