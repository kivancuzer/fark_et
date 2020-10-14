import 'package:fark_et/locator.dart';
import 'package:fark_et/model/student_model.dart';
import 'package:fark_et/services/auth_base.dart';
import 'package:fark_et/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  AuthBase authService = locator<FirebaseAuthService>();
  final VoidCallback onSignOut;
  final Student student;
  HomePage({Key key, @required this.onSignOut, @required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: _disconnect,
            child: Text(
              "Çıkış Yap",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        title: Text("Anasayfa"),
      ),
      body: Center(
        child: Text("Hoşgeldiniz ${student.studentId}"),
      ),
    );
  }

  Future<bool> _disconnect() async {
    bool result = await authService.signOut();
    onSignOut();
    return result;
  }
}
