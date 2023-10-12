import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/shared/constants.dart';

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

  @override
  Widget build(BuildContext context) {
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
                    borderSide: BorderSide(color: Colors.black12, width: 2.0),
                  )),
              validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            const SizedBox(height: 20.0),
            DropdownButtonFormField(
              value: _currentSugars ?? '0',
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
            const SizedBox(height: 20.0),
            Slider(
              min: 100,
              max: 900,
              divisions: 8,
              value: (_currentStrength ?? 100.0).toDouble(),
              onChanged: (val) =>
                  setState(() => _currentStrength = val.round()),
              activeColor: Colors.brown[_currentStrength ?? 100],
              inactiveColor: Colors.brown[_currentStrength ?? 100],
            ),
            const SizedBox(height: 20.0),
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
}
