import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/screens/authenticate/register.dart';
import 'package:flutter_firebase_project/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Register();
  }
}
