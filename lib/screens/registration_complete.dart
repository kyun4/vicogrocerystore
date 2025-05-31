import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vico_grocery_store/screens/mainmenu.dart';
import 'package:vico_grocery_store/screens/login.dart';
import 'dart:ui';

class RegistrationComplete extends StatefulWidget {
  const RegistrationComplete({super.key});
  @override
  State<RegistrationComplete> createState() => _registrationCompleteState();
}

class _registrationCompleteState extends State<RegistrationComplete> {
  void futureDelayed() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MainMenu();
          },
        ),
      );
    });
  }

  void showLoading() {
    showDialog(
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    child: Lottie.asset(
                      'assets/json_animations/loading-2.json',
                      height: 250,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  } // showLoading

  void nextPage() {
    // showLoading();
    // futureDelayed();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Login();
        },
      ),
    );
  } //nextPage

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,

              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/json_animations/registration-complete-1.json',
                      height: MediaQuery.of(context).size.height - 300,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain,
                    ),
                    ShaderMask(
                      shaderCallback:
                          (bounds) => LinearGradient(
                            colors: [Colors.lightBlue, Colors.deepPurpleAccent],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: Text(
                        "Registration Complete",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Text(
                      "Welcome to VICO Grocery Store!",
                      style: TextStyle(fontSize: 21),
                    ),
                    SizedBox(height: 45),
                    GestureDetector(
                      onTap: () {
                        nextPage();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
