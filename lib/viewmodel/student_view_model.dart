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

  Student get student => _student;

  ViewState get state => _state;

  set state(ViewState state) {
    _state = state;
    notifyListeners();
  }

  StudentViewModel() {
    currentStudent();
  }

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
}
