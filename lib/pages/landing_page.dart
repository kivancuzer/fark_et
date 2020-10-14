import 'package:fark_et/pages/home_page.dart';
import 'package:fark_et/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        onSignIn: (user) {
          _updateUser(user);
        },
      );
    } else {
      return HomePage(
        user: _user,
        onSignOut: () {
          _updateUser(null);
        },
      );
    }
  }

  Future<void> _checkUser() async {
    _user = FirebaseAuth.instance.currentUser;
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }
}
