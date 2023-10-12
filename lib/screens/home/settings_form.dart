import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/models/myuser.dart';
import 'package:flutter_firebase_project/services/database.dart';
import 'package:flutter_firebase_project/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  //this function needs to be async because it is called in the build method
  Future updateOnLoad(UserData userData) async {
    setState(() {
      _currentName = userData.name;
      _currentSugars = userData.sugars;
      _currentStrength = userData.strength;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          //snapshot is the data from the stream
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            UserData userData = snapshot.data!;
            updateOnLoad(userData);
            return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Update your brew settings.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Name',
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black12, width: 2.0),
                          )),
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                      initialValue: userData.name,
                    ),
                    const SizedBox(height: 30),
                    DropdownButtonFormField(
                      value: _currentSugars ?? userData.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(
                        () {
                          _currentSugars = val.toString();
                        },
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.grey[150],
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      label: '${_currentStrength ?? userData.strength}',
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        print(_currentName);
                        print(_currentSugars);
                        print(_currentStrength);
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ));
          }
        });
  }
}
