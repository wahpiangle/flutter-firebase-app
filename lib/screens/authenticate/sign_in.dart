import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/models/myuser.dart';
import 'package:flutter_firebase_project/services/auth.dart';

class SignIn extends StatefulWidget {
  //to obtain the toggleView function from the parent widget
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign In to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            style: TextButton.styleFrom(iconColor: Colors.black),
            icon: const Icon(Icons.person),
            label: const Text(
              'Register',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  print(email);
                  print(password);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                )),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ))),
    );
  }
}
