import 'package:flutter_test/flutter_test.dart';
import 'package:hahahaha/models/category.dart'; 

void main() {
  group('Category Test', () {
    test('Category.fromDbMap should create a Category object from a Map', () {
      // Arrange
      Map<String, dynamic> categoryMap = {'id': 1, 'title': 'Test Category'};
      // Act
      Category category = Category.fromDbMap(categoryMap);
      // Assert
      expect(category.id, equals(1));
      expect(category.title, equals('Test Category'));
    });
    test('Category.toDbMap should convert a Category object to a Map', () {
      // Arrange
      Category category = Category(id: 1, title: 'Test Category');
      // Act
      Map<String, dynamic> categoryMap = category.toDbMap();
      // Assert
      expect(categoryMap['id'], equals(1));
      expect(categoryMap['title'], equals('Test Category'));
    });
  });
}
