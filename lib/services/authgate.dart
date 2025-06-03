import 'package:flutter/material.dart';
import 'package:vico_grocery_store/screens/mainmenu.dart';
import 'package:vico_grocery_store/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});
  @override
  State<AuthGate> createState() => _authGateState();
}

class _authGateState extends State<AuthGate> {
  bool isLoggedIn = false;

  Widget pages = Splash();
  Widget pageSplash = Splash();

  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainMenu();
            },
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return pageSplash;
            },
          ),
        );
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}
