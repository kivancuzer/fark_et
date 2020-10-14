import 'package:fark_et/pages/home_page.dart';
import 'package:fark_et/pages/sign_in_page.dart';
import 'package:fark_et/viewmodel/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Page for the control Student
///
/// If Student exists open `HomePage`,
/// If Student does not exists open `SignInPage`.
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _studentViewModel = Provider.of<StudentViewModel>(context);
    //Check Student
    if (_studentViewModel.state == ViewState.IDLE) {
      if (_studentViewModel.student == null) {
        return SignInPage();
      } else {
        return HomePage(student: _studentViewModel.student);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
