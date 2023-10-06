import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_project/models/myuser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //auth change user stream
  //this is a getter, so when .user is called, it will return the stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges() //notify changes to user's sign in state
        .map((User? user) => _userFromFirebaseUser(
            user)); //.map to reassign every FirebaseUser in authStateChanges to _userFromFirebaseUser
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('error signing out');
      return null;
    }
  }
}
