import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//The AuthService class provides authentication and user management functionality for a Flutter app using Firebase Authentication and Firestore. It encapsulates common authentication tasks, such as signing in, signing up, and signing out, while ensuring user data is stored and managed properly.

class AuthService {
  //instance of auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance; //Handles user authentication
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; //Stores user data in the Firestore database.
  
  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithEmailPassword(
    String email,
    password,
  ) async {
    try {
      //sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //save user info if it doesn't already exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set( //The .set() method overwrites existing data if the document already exists.
        {
          'uid': userCredential.user!.uid,
          'email': email,
        }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      //create user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //save user info in a seperate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
  //errors
}
