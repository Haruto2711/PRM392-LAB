class Person {
  int id;
  String name;
  int age;

  Person({
    required this.id,
    required this.name,
    required this.age,
  });

  factory Person.fromJson(
      Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}