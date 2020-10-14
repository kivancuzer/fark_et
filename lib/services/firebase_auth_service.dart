import 'package:fark_et/services/auth_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fark_et/model/student_model.dart';

///Firebase Authentication Operations
///
///Singleton Pattern `FirebaseAuth`
class FirebaseAuthService implements AuthBase {
  //Instance of FirebaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ///Get Current Student
  ///
  ///Returns `student` if user exists
  ///Returns `null` if user not exists
  @override
  Future<Student> currentStudent() async {
    try {
      User user = await Future.value(_firebaseAuth.currentUser);
      return _userFromFirebase(user);
    } catch (e) {
      print("HATA CURRENT USER : " + e.toString());
      return null;
    }
  }

  ///Convert FirebaseUser `User` to `Student`
  ///
  ///[user] which is convert to Student
  ///Returns `student` which is converted from User
  Student _userFromFirebase(User user) {
    if (user == null) return null;
    return Student(studentId: user.uid);
  }

  ///Sign In Anonymously
  ///
  ///Returns `Student` which is sign in anonymously
  @override
  Future<Student> signInAnonymously() async {
    try {
      User user = (await _firebaseAuth.signInAnonymously()).user;
      return _userFromFirebase(user);
    } catch (e) {
      print("HATA SIGN IN ANONYMOUSLY : " + e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("HATA SIGN OUT : " + e.toString());
      return false;
    }
  }
}
