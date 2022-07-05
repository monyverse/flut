import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DaochatFirebaseUser {
  DaochatFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

DaochatFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DaochatFirebaseUser> daochatFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<DaochatFirebaseUser>(
        (user) => currentUser = DaochatFirebaseUser(user));
