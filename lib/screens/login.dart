import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:vico_grocery_store/components/textfield.dart';
import 'package:vico_grocery_store/screens/mainmenu.dart';
import 'package:vico_grocery_store/screens/register.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _loginState();
}

class _loginState extends State<Login> {
  TextEditingController textEmailController = new TextEditingController();
  TextEditingController textPasswordController = new TextEditingController();
  String? email_note;
  String? password_note;

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

  Future<String> login(String email, String password) async {
    String errorString = "";

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      nextPage();
    } catch (error) {
      errorString = error.toString();
      //throw error;
    }

    return errorString;
  } //login

  void registerPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Register();
        },
      ),
    );
  } // registerPage

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
                    hintText: "Email Address",
                    iconPrefix: Icon(
                      Icons.email_outlined,
                      color: Colors.lightBlueAccent,
                    ),
                    iconSuffix: Icon(Icons.email, color: Colors.transparent),
                    textController: textEmailController,
                  ),
                  Visibility(
                    visible:
                        email_note == null || email_note == "" ? false : true,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 68, right: 25),
                          child: Text(
                            email_note ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),

                  TextFieldCustom(
                    isObscureText: true,
                    hintText: "Password",
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
                  Visibility(
                    visible:
                        password_note == null || password_note == ""
                            ? false
                            : true,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 68, right: 25),
                          child: Text(
                            password_note ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      String email = textEmailController.text;
                      String password = textPasswordController.text;

                      if (email.isEmpty) {
                        setState(() {
                          email_note = "Email is empty";
                        });
                      } else {
                        setState(() {
                          email_note = "";
                        });
                      }

                      if (password.isEmpty) {
                        setState(() {
                          password_note = "Password is empty";
                        });
                      } else {
                        setState(() {
                          password_note = "";
                        });
                      }

                      String errorString = await login(email, password);

                      if (errorString.isNotEmpty) {
                        if (errorString.toLowerCase().trim() ==
                            "[firebase_auth/invalid-credential] the supplied auth credential is incorrect, malformed or has expired.") {
                          setState(() {
                            password_note = "Email or Password is Invalid";
                          });
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(35),
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
                        Text("Not yet registered?"),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            registerPage();
                          },
                          child: Text(
                            "Register Now!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
