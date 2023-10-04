import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/screens/authenticate/sign_in.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // return either home or authenticate widget
    return Container(
      child: SignIn(),
    );
  }
}
