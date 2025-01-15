import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:united/services/auth/login_or_register.dart';
import 'package:united/page/home_page.dart';
//this page is listening whether we are signed in or not
//FirebaseAuth: Provides the authStateChanges stream to monitor authentication events.
//LoginOrRegister: Displays the login and registration options.
//HomePage: Displays the main app content for authenticated users.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          //user is logged in
          if(snapshot.hasData){
            return HomePage();
          }
          //user not logged in
          else{
            return const LoginOrRegister();
          }
        }
      )
    );
  }
}
