import 'package:fark_et/locator.dart';
import 'package:fark_et/model/student_model.dart';
import 'package:fark_et/services/auth_base.dart';
import 'package:fark_et/services/fake_auth_service.dart';
import 'package:fark_et/services/firebase_auth_service.dart';

/// 2 Mode for App
/// Debug is for FakeAuth
/// Release is for FirebaseAuth
enum AppMode { DEBUG, RELEASE }

/// Repository Class for Student
class StudentRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService =
      locator<FakeAuthenticationService>();

  AppMode appMode = AppMode.RELEASE;

  /// Get Current Student
  @override
  Future<Student> currentStudent() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.currentStudent();
    } else {
      return await _firebaseAuthService.currentStudent();
    }
  }

  /// Sign In With Anonymously
  @override
  Future<Student> signInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInAnonymously();
    } else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  /// Sign Out
  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  ///Sign In With Google
  @override
  Future<Student> googleSignIn() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.googleSignIn();
    } else {
      return await _firebaseAuthService.googleSignIn();
    }
  }
}
