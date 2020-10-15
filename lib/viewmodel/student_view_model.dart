import 'package:fark_et/locator.dart';
import 'package:fark_et/model/student_model.dart';
import 'package:fark_et/repository/student_repository.dart';
import 'package:fark_et/services/auth_base.dart';
import 'package:flutter/cupertino.dart';

enum ViewState { IDLE, BUSY }

class StudentViewModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.IDLE;
  StudentRepository _studentRepository = locator<StudentRepository>();
  Student _student;
  String emailErrorMessage;
  String passwordErrorMessage;

  // Get Student
  Student get student => _student;
  // Get ViewState
  ViewState get state => _state;

  set state(ViewState state) {
    _state = state;
    notifyListeners();
  }

  StudentViewModel() {
    currentStudent();
  }

  /// Get Current Student
  ///
  /// Set ViewState `BUSY` while getting student.
  /// Trigger the `_studentRepository` for current student.
  @override
  Future<Student> currentStudent() async {
    try {
      state = ViewState.BUSY;
      _student = await _studentRepository.currentStudent();
      return _student;
    } catch (e) {
      debugPrint("ViewModel current user error : " + e.toString());
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  /// Sign Out
  ///
  /// Set ViewState `BUSY` while signed out.
  /// Trigger the `_studentRepository` for signed out.
  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.BUSY;
      bool result = await _studentRepository.signOut();
      _student = null;
      return result;
    } catch (e) {
      debugPrint("ViewModel sign out error : " + e.toString());
      return false;
    } finally {
      state = ViewState.IDLE;
    }
  }

  /// Sign In Anonymously
  ///
  /// Set ViewState `BUSY` while signing with anonymously.
  /// Trigger the `_studentRepository` for sign with anonymously.
  @override
  Future<Student> signInAnonymously() async {
    try {
      state = ViewState.BUSY;
      _student = await _studentRepository.signInAnonymously();
      return _student;
    } catch (e) {
      debugPrint("ViewModel sign in anonymously error : " + e.toString());
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  /// Sign In With Google
  ///
  /// Set ViewState `BUSY` when signed in with google.
  /// Trigger the `_studentRepository` for sign in with google.
  @override
  Future<Student> googleSignIn() async {
    try {
      state = ViewState.BUSY;
      _student = await _studentRepository.googleSignIn();
      return _student;
    } catch (e) {
      debugPrint("ViewModel sign in anonymously error : " + e.toString());
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  /// Sign In With Google
  ///
  /// Set ViewState `BUSY` when signed in with google.
  /// Trigger the `_studentRepository` for sign in with google.
  @override
  Future<Student> signInWithEmail(String email, String password) async {
    try {
      if (_emailAndPasswordControl(email, password)) {
        state = ViewState.BUSY;
        _student = await _studentRepository.signInWithEmail(email, password);
        return _student;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("ViewModel sign in anonymously error : " + e.toString());
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  /// Create Student With Email
  ///
  /// Set ViewState `BUSY` when created student.
  /// Trigger the `_studentRepository` for create student with email.
  @override
  Future<Student> createStudentWithEmail(String email, String password) async {
    try {
      if (_emailAndPasswordControl(email, password)) {
        state = ViewState.BUSY;
        _student =
            await _studentRepository.createStudentWithEmail(email, password);
        return _student;
      } else
        return null;
    } catch (e) {
      debugPrint("ViewModel sign in anonymously error : " + e.toString());
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  bool _emailAndPasswordControl(String email, String password) {
    var result = true;
    if (password.length < 6) {
      passwordErrorMessage = "Şifre en az 6 karakter olmalı";
      result = false;
    } else
      passwordErrorMessage = null;
    if (!email.contains("@")) {
      emailErrorMessage = "Geçersiz Email adresi";
      result = false;
    } else
      emailErrorMessage = null;
    return result;
  }
}
