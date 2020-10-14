import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User user;
  final VoidCallback onSignOut;
  HomePage({Key key, this.user, @required this.onSignOut}) : super(key: key);

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
        child: Text("Hoşgeldiniz {$user.uid}"),
      ),
    );
  }

  Future<void> _disconnect() async {
    await FirebaseAuth.instance.signOut();
    onSignOut();
  }
}
