import 'package:hive/hive.dart';

part 'user.g.dart'; // This should match the generated file name

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String password;

  User(
      {required this.username,
      required this.firstName,
      required this.password});
}
