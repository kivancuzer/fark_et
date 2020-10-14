import 'package:fark_et/model/student_model.dart';
import 'package:fark_et/viewmodel/student_view_model.dart';
import 'package:fark_et/widgets/sing_in_page_widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fark Et"),
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Oturum Aç",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(
              height: 8,
            ),
            SocialLoginButton(
              buttonText: "Gmail İle Giriş Yap",
              textColor: Colors.black87,
              buttonColor: Colors.white,
              buttonIcon: Image.asset("images/google-logo.png"),
              onPressed: () {},
            ),
            SocialLoginButton(
              onPressed: () {},
              buttonText: "Facebook İle Giriş Yap",
              buttonIcon: Image.asset("images/facebook-logo.png"),
              buttonColor: Color(0xFF334D92),
            ),
            SocialLoginButton(
              onPressed: () {},
              buttonIcon: Icon(
                Icons.supervised_user_circle,
                size: 32,
                color: Colors.white,
              ),
              buttonColor: Colors.teal,
              buttonText: "Email İle Giriş Yap",
            ),
            SocialLoginButton(
              onPressed: () => _signInAnonymously(context),
              buttonIcon: Icon(
                Icons.supervised_user_circle,
                size: 32,
                color: Colors.white,
              ),
              buttonColor: Colors.teal,
              buttonText: "Misafir Girişi",
            ),
          ],
        ),
      ),
    );
  }

  void _signInAnonymously(BuildContext context) async {
    final _studentViewModel =
        Provider.of<StudentViewModel>(context, listen: false);
    Student _student = await _studentViewModel.signInAnonymously();
    print("Oturum Açan student id : " + _student.studentId);
  }
}
