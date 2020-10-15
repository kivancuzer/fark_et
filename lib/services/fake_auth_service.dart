import 'package:fark_et/model/student_model.dart';
import 'package:fark_et/services/auth_base.dart';

/// Fake Authentication Class
///
/// When firebase functions not work well
/// UI can use this class
class FakeAuthenticationService implements AuthBase {
  String _studentId = "123123123";

  /// Returns current fake student
  @override
  Future<Student> currentStudent() async {
    return await Future.value(Student(studentId: _studentId));
  }

  /// Sign in Anonymously
  ///
  /// Returns `student` like anonymously signed in
  @override
  Future<Student> signInAnonymously() async {
    return Future.delayed(
        Duration(seconds: 2), () => Student(studentId: _studentId));
  }

  /// Fake Sign Out
  ///
  /// Returns `true` like signed out success.
  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<Student> googleSignIn() {
    return Future.delayed(
        Duration(seconds: 2), () => Student(studentId: _studentId));
  }

  @override
  Future<Student> signInWithEmail(String email, String password) {
    return Future.delayed(
        Duration(seconds: 2), () => Student(studentId: _studentId));
  }

  @override
  Future<Student> createStudentWithEmail(String email, String password) {
    return null;
  }
}
