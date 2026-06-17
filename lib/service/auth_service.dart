import 'package:firebase_auth/firebase_auth.dart';

class Id {
  String? uid;
  String? email;
  Id({required this.uid, required this.email});
}

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
Future<Id?> signUp(String email, String password) async {
  try {
     UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      String? uid = userCredential.user!.uid;
      String? idEmail = userCredential.user!.email;
      return Id(uid: uid, email: idEmail);
    }
  } on FirebaseAuthException catch (_) {
    rethrow;
  }
  return null;
}

Future<Id?> signIn(String email, String password) async {
  try {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      String? uid = userCredential.user!.uid;
      String? idEmail = userCredential.user!.email;
      return Id(uid: uid, email: idEmail);
    }
  } on FirebaseAuthException catch (_) {
    rethrow;
  }
  return null;
}

Future<void> signOut() async {
  await _firebaseAuth.signOut();
}
Id? getCurrentUser() {
  final user = _firebaseAuth.currentUser;
  if (user != null) {
    return Id(uid: user.uid, email: user.email);
  }
  return null;
}




