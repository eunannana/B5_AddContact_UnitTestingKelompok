class Category {
  int id;
  String title;

  // Konstruktor dengan parameter bernama
  Category({required this.id, required this.title});

  // Metode factory untuk membuat objek dari Map
  factory Category.fromDbMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      title: map['title'],
    );
  }

  // Metode untuk mengonversi objek ke dalam Map
  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
