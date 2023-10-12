import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_project/models/brew.dart';
import 'package:flutter_firebase_project/models/myuser.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc['name'] ?? '',
        sugars: doc['sugars'] ?? 0,
        strength: doc['strength'] ?? '0',
      );
    }).toList();
  }

  //convert snapshot to UserData
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot['name'],
      sugars: snapshot['sugars'],
      strength: snapshot['strength'],
    );
  }

  //stream to get all brews collection
  //the value can be accessed using StreamProvider<List<Brew>?>.value(
  // data: DatabaseService(uid: '').brews,
  //)
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshots);
  }

  //user document stream to get brew that belongs to the user
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
