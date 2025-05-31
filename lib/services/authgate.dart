import 'package:flutter/material.dart';
import 'package:vico_grocery_store/screens/mainmenu.dart';
import 'package:vico_grocery_store/screens/splash.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});
  @override
  State<AuthGate> createState() => _authGateState();
}

class _authGateState extends State<AuthGate> {
  bool isLoggedIn = false;

  Widget pages = Splash();

  void initState() {
    super.initState();

    if (isLoggedIn) {
      pages = MainMenu();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return pages;
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}
