import 'package:fark_et/locator.dart';
import 'package:fark_et/model/student_model.dart';
import 'package:fark_et/services/auth_base.dart';
import 'package:fark_et/services/firebase_auth_service.dart';
import 'package:fark_et/widgets/sing_in_page_widgets/social_login_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  final Function(Student) onSignIn;
  AuthBase authService = locator<FirebaseAuthService>();
  SignInPage({Key key, @required this.onSignIn}) : super(key: key);

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
              onPressed: signInAnonymously,
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

  void signInAnonymously() async {
    Student _student = await authService.signInAnonymously();
    onSignIn(_student);
    print("Oturum Açan student id : " + _student.studentId);
  }
}
