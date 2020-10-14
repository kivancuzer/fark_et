import 'package:fark_et/locator.dart';
import 'package:fark_et/model/student_model.dart';
import 'package:fark_et/services/auth_base.dart';
import 'package:fark_et/services/fake_auth_service.dart';
import 'package:fark_et/services/firebase_auth_service.dart';

enum AppMode { DEBUG, RELEASE }

class StudentRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService =
      locator<FakeAuthenticationService>();

  AppMode appMode = AppMode.DEBUG;
  @override
  Future<Student> currentStudent() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.currentStudent();
    } else {
      return await _firebaseAuthService.currentStudent();
    }
  }

  @override
  Future<Student> signInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInAnonymously();
    } else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }
}
