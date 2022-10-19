enum AccessLevel { low, medium, hight }

class User {
  const User({
    required this.name,
    required this.age,
    this.accessLevel = AccessLevel.low,
  });

  final String name;
  final int age;
  final AccessLevel accessLevel;
}