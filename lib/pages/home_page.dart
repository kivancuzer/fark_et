import 'package:fark_et/model/student_model.dart';
import 'package:fark_et/viewmodel/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final Student student;
  HomePage({Key key, @required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () => _disconnect(context),
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

  Future<bool> _disconnect(BuildContext context) async {
    final _studentViewModel =
        Provider.of<StudentViewModel>(context, listen: false);
    bool result = await _studentViewModel.signOut();
    return result;
  }
}
