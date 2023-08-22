class Person {
  final String id;
  final String name;
  final String img;
  final String category;
  final String gender;

  Person({
    required this.id,
    required this.name,
    required this.img,
    required this.category,
    required this.gender,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      category: json['category'],
      gender: json['gender'],
    );
  }
}
