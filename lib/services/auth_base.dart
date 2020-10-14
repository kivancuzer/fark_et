import 'package:fark_et/model/student_model.dart';

///Base class for Authentication
abstract class AuthBase {
  Future<Student> currentStudent();
  Future<Student> signInAnonymously();
  Future<bool> signOut();
}
