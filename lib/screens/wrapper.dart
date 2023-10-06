import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/models/myuser.dart';
import 'package:flutter_firebase_project/screens/authenticate/authenticate.dart';
import 'package:flutter_firebase_project/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(
        context); //look for MyUser type data from the provider

    // return either Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
