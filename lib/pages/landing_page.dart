import 'package:fark_et/locator.dart';
import 'package:fark_et/model/student_model.dart';
import 'package:fark_et/pages/home_page.dart';
import 'package:fark_et/pages/sign_in_page.dart';
import 'package:fark_et/services/auth_base.dart';
import 'package:fark_et/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Student _student;
  AuthBase authService = locator<FirebaseAuthService>();
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_student == null) {
      return SignInPage(
        onSignIn: (student) {
          _updateUser(student);
        },
      );
    } else {
      return HomePage(
        student: _student,
        onSignOut: () {
          _updateUser(null);
        },
      );
    }
  }

  Future<void> _checkUser() async {
    _student = await authService.currentStudent();
  }

  void _updateUser(Student student) {
    setState(() {
      _student = student;
    });
  }
}
