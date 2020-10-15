import 'package:fark_et/services/auth_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fark_et/model/student_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Firebase Authentication Operations
///
/// Singleton Pattern `FirebaseAuth`
class FirebaseAuthService implements AuthBase {
  // Instance of FirebaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Get Current Student
  ///
  /// Returns `student` if user exists.
  /// Returns `null` if user not exists.
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

  /// Convert FirebaseUser `User` to `Student`
  ///
  /// [user] which is convert to Student.
  /// Returns `student` which is converted from User.
  Student _userFromFirebase(User user) {
    if (user == null) return null;
    return Student(studentId: user.uid);
  }

  /// Sign Out
  ///
  /// Returns `true` if signed out success.
  /// Returns `false` if signed out fail.
  @override
  Future<bool> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("HATA SIGN OUT : " + e.toString());
      return false;
    }
  }

  /// Sign In Anonymously
  ///
  /// Returns `Student` which is sign in anonymously.
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

  ///Sign In With Google
  ///
  /// Returns `Student` which is signed with gmail.
  @override
  Future<Student> googleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        User user = (await _firebaseAuth.signInWithCredential(
                GoogleAuthProvider.credential(
                    idToken: _googleAuth.idToken,
                    accessToken: _googleAuth.accessToken)))
            .user;
        return _userFromFirebase(user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  ///Sign In With Email
  ///
  ///Returns `Student` if success
  @override
  Future<Student> signInWithEmail(String email, String password) async {
    try {
      User user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return _userFromFirebase(user);
    } catch (e) {
      print("HATA SIGN IN ANONYMOUSLY : " + e.toString());
      return null;
    }
  }

  ///Create Student With Email
  ///
  ///Returns `Student` if doesn't exists and success
  @override
  Future<Student> createStudentWithEmail(String email, String password) async {
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      return _userFromFirebase(user);
    } catch (e) {
      print("HATA SIGN IN ANONYMOUSLY : " + e.toString());
      return null;
    }
  }
}
