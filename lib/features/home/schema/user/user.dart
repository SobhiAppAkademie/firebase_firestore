import 'package:recap/features/home/schema/user/abgabe.dart';

class User {
  final String name;
  final String role;

  final List<Abgabe> abgaben;

  User({required this.name, required this.role, required this.abgaben});

  // JSON to User-Klasse
  factory User.fromMap(Map<String, dynamic> map, List<Abgabe> abgaben) {
    final String name = map["name"];
    final String role = map["role"];

    return User(name: name, role: role, abgaben: abgaben);
  }
}


// User user = User.fromMap(firestoreMap, abgaben);