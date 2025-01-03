import 'package:flutter/material.dart';
import 'package:united/auth/auth_service.dart';
import 'package:united/components/my_button.dart';
import 'package:united/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  //tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //register method
  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();
    //passwords match=> create user
    if (_pwController.text == _confirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey,
            title: Text(
              e.toString(),
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    }

    //passwords don't match => tell user to fix
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          backgroundColor: Colors.grey,
          title: Text(
            "Password is not confirmed correctly",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          //logo
          Image(
            image: AssetImage('lib/iconsimade/logou.png'),
          ),
          const SizedBox(height: 40),
          //welcomeback message
          Text(
            "Create your new account!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          //email textfield
          MyTextfield(
            hintText: "Enter your Email",
            obscureText: false,
            controller: _emailController,
          ),
          const SizedBox(height: 8),
          //pw textfield
          MyTextfield(
            hintText: "Enter your Password",
            obscureText: true,
            controller: _pwController,
          ),
          const SizedBox(height: 8),
          //cfpw textfield
          MyTextfield(
            hintText: "Confirm Password",
            obscureText: true,
            controller: _confirmPwController,
          ),
          const SizedBox(height: 20),
          //login button
          MyButton(
            text: "Register",
            onTap: () => register(context),
          ),
          const SizedBox(height: 20),
          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already a member? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
