import 'package:fark_et/locator.dart';
import 'package:fark_et/pages/landing_page.dart';
import 'package:fark_et/viewmodel/student_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fark Et",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: ChangeNotifierProvider(
          create: (context) => StudentViewModel(), child: LandingPage()),
    );
  }
}
