import 'package:fark_et/model/student_model.dart';
import 'package:fark_et/viewmodel/student_view_model.dart';
import 'package:fark_et/widgets/sing_in_page_widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FormType { Register, Login }

class SignInWithEmailPage extends StatefulWidget {
  @override
  _SignInWithEmailPageState createState() => _SignInWithEmailPageState();
}

class _SignInWithEmailPageState extends State<SignInWithEmailPage> {
  String _email, _password;
  String _buttonText, _linkText;
  var _formType = FormType.Login;
  final _formKey = GlobalKey<FormState>();
  void _formSubmit() async {
    _formKey.currentState.save();
    debugPrint("email : " + _email + " password : " + _password);
    final _userModel = Provider.of<StudentViewModel>(context, listen: false);
    if (_formType == FormType.Login) {
      Student _signInStudent =
          await _userModel.signInWithEmail(_email, _password);
      if (_signInStudent != null)
        print("Oturum açan user id : " + _signInStudent.studentId.toString());
    } else {
      Student _createdStudent =
          await _userModel.createStudentWithEmail(_email, _password);
      if (_createdStudent != null)
        print("Oturum açan user id : " + _createdStudent.studentId.toString());
    }
  }

  void _change() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.Login ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.Login
        ? "Hesabınız Yok Mu ? Kayıt Olun"
        : "Hesabınız Var Mı ? Giriş Yapın";

    final _studentViewModel = Provider.of<StudentViewModel>(context);
    //Check Student
    if (_studentViewModel.student != null) {
      Future.delayed(Duration(milliseconds: 10), () {
        Navigator.of(context).pop();
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş / Kayıt"),
      ),
      body: _studentViewModel.state == ViewState.IDLE
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorText: _studentViewModel.emailErrorMessage != null
                              ? _studentViewModel.emailErrorMessage
                              : null,
                          prefix: Icon(Icons.mail),
                          hintText: "Email",
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String email) {
                          _email = email;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          errorText:
                              _studentViewModel.passwordErrorMessage != null
                                  ? _studentViewModel.passwordErrorMessage
                                  : null,
                          prefix: Icon(Icons.email),
                          hintText: "Şifre",
                          labelText: "Şifre",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String password) {
                          _password = password;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      SocialLoginButton(
                        buttonText: _buttonText,
                        buttonColor: Colors.amber,
                        onPressed: () => _formSubmit(),
                        radius: 20,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      FlatButton(
                        onPressed: () => _change(),
                        child: Text(_linkText),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
