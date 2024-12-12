import 'package:recap/features/home/schema/user/abgabe.dart';
import 'package:recap/features/home/schema/user/user.dart';

abstract class DatabaseUserRepository {
  Future<List<User>> getUsers();
  Future<List<Abgabe>> getAbgaben(String userId);
}
