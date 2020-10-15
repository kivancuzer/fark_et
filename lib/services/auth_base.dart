import 'package:fark_et/model/student_model.dart';

/// Base class for Authentication
abstract class AuthBase {
  Future<Student> currentStudent();
  Future<Student> signInAnonymously();
  Future<bool> signOut();
  Future<Student> googleSignIn();
  Future<Student> signInWithEmail(String email, String password);
  Future<Student> createStudentWithEmail(String email, String password);
}
