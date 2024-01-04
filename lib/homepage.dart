/// home_page.dart
///
/// This Dart file defines the `HomePage` class, a StatefulWidget that
/// provides functionality to create and store categories. It utilizes
/// SQLite database operations for category management.
///

// Importing necessary packages and files
import 'package:flutter/material.dart';
import 'package:hahahaha/colors.dart';

import 'mydrawal.dart';
import 'db_manager.dart';

/// The `HomePage` class is a StatefulWidget that provides functionality
/// to create and store categories.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

/// The `_HomePageState` class is the corresponding State class for the
/// `HomePage` widget.
class _HomePageState extends State<HomePage> {
  // Instance of the DatabaseHelper for interacting with the SQLite database.
  final dbHelper = DatabaseHelper.instance;

  // List to store all category data retrieved from the database.
  List<Map<String, dynamic>> allCategoryData = [];

  // TextEditingController for managing the input category name.
  TextEditingController _categoryName = TextEditingController();

  // GlobalKey for managing the Form state.
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // Initialize the state by querying the database for all category data.
    _query();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Drawer for additional navigation options.
        drawer: MyDrawal(),
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          centerTitle: true,
          title: Text("Create and Store Category"),
        ),
        body: Form(
          key: formGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      // Text input field for adding a new category.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            child: TextFormField(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyColors.primaryColor, width: 1.0),
                                ),
                                hintText: 'Add Category',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                              ),
                              controller: _categoryName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter category name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // Button for saving the entered category.
                      TextButtonTheme(
                        data: TextButtonThemeData(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                MyColors.primaryColor),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Validate the form before attempting to save.
                            if (formGlobalKey.currentState!.validate()) {
                              _insert();
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // Expanded ListView for displaying the list of categories.
                      Expanded(
                        child: ListView.builder(
                          itemCount: allCategoryData.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) {
                            var item = allCategoryData[index];
                            return Container(
                              color: MyColors.orangeTile,
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  // Displaying category name and action buttons.
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("${item['name']}"),
                                      Spacer(),
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
                                  // Divider for separating categories.
                                  const Divider(
                                    color: MyColors.orangeDivider,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Private method to insert a new category into the database.
  void _insert() async {
    // Row to insert into the 'category' table.
    Map<String, dynamic> row = {DatabaseHelper.columnName: _categoryName.text};
    print('insert start');

    // Inserting row into the 'category' table.
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    
    // Clearing the input field and updating the displayed category list.
    _categoryName.text = "";
    _query();
  }

  /// Private method to query all rows from the 'category' table.
  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
    
    // Updating the list of categories.
    allCategoryData = allRows;
    setState(() {});
  }

  /// Private method to delete a category with the specified ID from the database.
  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
    
    // Updating the list of categories after deletion.
    _query();
  }
}
