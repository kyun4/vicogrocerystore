import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:vico_grocery_store/components/textfield.dart';
import 'package:vico_grocery_store/screens/mainmenu.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _loginState();
}

class _loginState extends State<Login> {
  TextEditingController textEmailController = new TextEditingController();

  TextEditingController textPasswordController = new TextEditingController();

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
    showLoading();
    futureDelayed();
  } //nextPage

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.transparent),
        centerTitle: true,
        title: Text(
          "VICO Grocery Store | Shop Everyday",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: 12.5),
                  Icon(Icons.login_outlined, size: 25),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 22.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),

                  TextFieldCustom(
                    isObscureText: false,
                    hintText: "Enter Registered Email Address",
                    iconPrefix: Icon(
                      Icons.email_outlined,
                      color: Colors.lightBlueAccent,
                    ),
                    iconSuffix: Icon(Icons.email, color: Colors.transparent),
                    textController: textEmailController,
                  ),

                  TextFieldCustom(
                    isObscureText: true,
                    hintText: "Enter Password",
                    iconPrefix: Icon(
                      Icons.lock_outline,
                      color: Colors.lightBlueAccent,
                    ),
                    iconSuffix: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.black38,
                    ),
                    textController: textPasswordController,
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      nextPage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(20),
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
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already registered?"),
                        SizedBox(width: 5),
                        Text(
                          "Login Now",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
