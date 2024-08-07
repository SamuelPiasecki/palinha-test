class User {
  final String id;
  final String name;
  final int age;
  final String phone;
  final String avatar;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.avatar,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      phone: map['phone'],
      avatar: map['avatar'],
    );
  }
}
