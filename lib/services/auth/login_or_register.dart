import 'package:flutter/material.dart';
import 'package:united/page/login_page.dart';
import 'package:united/page/register_page.dart';
//The LoginOrRegister widget acts as a navigation handler to toggle between the LoginPage and the RegisterPage

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially, show login page
  bool showLoginPage = true;

  //toggle btw login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
