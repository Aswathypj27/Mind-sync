import 'package:flutter/material.dart';
import 'screen/login_screen.dart';

void main() {
  runApp(StudySphereFunMode());
}

class StudySphereFunMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
