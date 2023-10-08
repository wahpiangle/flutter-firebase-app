import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/services/auth.dart';

class Register extends StatefulWidget {
  //to obtain the toggleView function from the parent widget
  final Function toggleView;

  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //to identify our form

  String email = '';
  String password = '';
  String error = '';

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
              'Sign In',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter an email' : null,
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
                  validator: (value) => value!.length < 6
                      ? 'Enter a password 6+ chars long'
                      : null,
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
                    //this will check for the helper string in the validator
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Please supply a valid email';
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  )),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          )),
    );
  }
}
