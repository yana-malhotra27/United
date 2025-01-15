import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united/services/auth/auth_gate.dart';
import 'package:united/firebase_options.dart';
import 'package:united/themes/theme_provider.dart';
//basic flow
//Flutter gets ready, and Firebase is set up.
//The app loads the theme settings using ThemeProvider.
//The app checks if the user is logged in (via AuthGate) and shows the appropriate screen (like login or home).

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //to make sure that flutter is ready
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); //firebase setup
  runApp( //start app
    ChangeNotifierProvider( //theme manager
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(), //Decides the first screen to show (AuthGate), which checks if the user is logged in.
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
