import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/models/brew.dart';
import 'package:flutter_firebase_project/screens/home/brew_list.dart';
import 'package:flutter_firebase_project/services/auth.dart';
import 'package:flutter_firebase_project/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('Brew Crew'),
          actions: <Widget>[
            //actions will appear to top right of navbar
            TextButton.icon(
              icon: const Icon(Icons.person, color: Colors.black),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
