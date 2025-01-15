import 'package:flutter/material.dart';
import 'package:united/services/auth/auth_service.dart';
import 'package:united/components/my_button.dart';
import 'package:united/components/my_textfield.dart';
//flow
//Enter email and password.
//Tap a "Login" button to log in.
//Navigate to the registration page.
class LoginPage extends StatelessWidget {
  //email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  //tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  //login method
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
    }

    //catch any errors
    catch (e) {
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
            "Welcome back let's unite!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          //email textfield
          MyTextField(
            hintText: "Enter your Email",
            obscureText: false,
            controller: _emailController,
          ),
          const SizedBox(height: 8),
          //pw textfield
          MyTextField(
            hintText: "Enter your Password",
            obscureText: true, //hides pw
            controller: _pwController,
          ),
          const SizedBox(height: 20),
          //login button
          MyButton(
            text: "Login",
            onTap: () => login(context),
          ),
          const SizedBox(height: 20),
          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New member? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register now",
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
