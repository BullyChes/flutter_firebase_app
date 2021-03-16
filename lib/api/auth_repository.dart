import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_app/models/user.dart';
import 'package:meta/meta.dart';
import 'exceptions.dart';

abstract class AuthRepositoryInterface {
  Stream<User> get user;
  Future<void> signUp({@required String email, @required String password});
  Future<void> loginWith({@required String email, @required String password});
  Future<void> logOut();
}

class AuthRepository implements AuthRepositoryInterface {
  AuthRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty : firebaseUser.toUser;
    });
  }

  Future<void> signUp(
      {@required String email, @required String password}) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> loginWith(
      {@required String email, @required String password}) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
