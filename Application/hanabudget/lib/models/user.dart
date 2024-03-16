import 'package:hive/hive.dart';

part 'user.g.dart'; // This should match the generated file name

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  String password; // Removed 'final' to allow updating

  @HiveField(3)
  final String securityQuestion;

  @HiveField(4)
  final String securityAnswer;

  User({
    required this.username,
    required this.firstName,
    required this.password,
    required this.securityQuestion,
    required this.securityAnswer,
  });

  // Optional: Add a setter for password if you want to include additional logic
  set updatePassword(String newPassword) {
    // Here you could include validation or encryption before setting the password
    password = newPassword;
  }
}
