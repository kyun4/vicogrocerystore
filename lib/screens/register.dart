import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vico_grocery_store/components/textfield.dart';
import 'package:vico_grocery_store/components/textfield_number.dart';
import 'package:vico_grocery_store/components/textfieldobscure.dart';
import 'package:vico_grocery_store/screens/registration_complete.dart';
import 'package:vico_grocery_store/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vico_grocery_store/services/firebaseServices.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _registerState();
}

void registerUser(
  String email,
  String phone,
  String username,
  String password,
  BuildContext context,
) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    String emailRegistered = userCredential.user!.email.toString();
    String uid = userCredential.user!.uid.toString();

    Provider.of<FirebaseServices>(
      context,
      listen: false,
    ).addUser(uid, emailRegistered, phone, username);
  } catch (error) {
    throw error;
  }
} // registerUser

class _registerState extends State<Register> {
  TextEditingController textEmailController = new TextEditingController();
  TextEditingController textPhoneController = new TextEditingController();
  TextEditingController textUsernameController = new TextEditingController();
  TextEditingController textDesiredPasswordController =
      new TextEditingController();
  TextEditingController textRetryPasswordController =
      new TextEditingController();

  bool isSubmit = false;
  String? password_note;
  String? retry_password_note;
  String? email_note;
  String? phone_note;
  String? username_note;

  void futureDelayed() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return RegistrationComplete();
          },
        ),
      );
    });
  }

  void goToNextPage() {} //

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
                  Icon(Icons.app_registration_rounded, size: 25),
                  Container(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 22.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFieldCustom(
                    isObscureText: false,
                    hintText: "Desired Username",
                    iconPrefix: Icon(
                      Icons.person_2_outlined,
                      color: Colors.lightBlueAccent,
                    ),
                    iconSuffix: Icon(Icons.email, color: Colors.transparent),
                    textController: textUsernameController,
                  ),
                  Visibility(
                    visible:
                        username_note == null || username_note == ""
                            ? false
                            : true,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 68),
                          child: Text(
                            username_note ?? "",
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
                          padding: const EdgeInsets.only(left: 68),
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
                  TextFieldNumberCustom(
                    isObscureText: false,
                    hintText: "Phone",
                    iconPrefix: Icon(
                      Icons.mobile_friendly_outlined,
                      color: Colors.lightBlueAccent,
                    ),
                    iconSuffix: Icon(Icons.email, color: Colors.transparent),
                    textController: textPhoneController,
                  ),
                  Visibility(
                    visible:
                        phone_note == null || phone_note == "" ? false : true,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 68),
                          child: Text(
                            phone_note ?? "",
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

                  TextFieldObscureCustom(
                    isObscureText: true,
                    hintText: "Desired Password",
                    iconPrefix: Icon(
                      Icons.lock_outline,
                      color: Colors.lightBlueAccent,
                    ),
                    iconSuffix: Icon(
                      Icons.visibility_outlined,
                      color: Colors.black38,
                    ),
                    textController: textDesiredPasswordController,
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
                          padding: const EdgeInsets.only(left: 68),
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

                  TextFieldObscureCustom(
                    isObscureText: true,
                    hintText: "Confirm Password",
                    iconPrefix: Icon(
                      Icons.lock_outline,
                      color: Colors.lightBlueAccent,
                    ),
                    iconSuffix: Icon(
                      Icons.visibility_outlined,
                      color: Colors.black38,
                    ),
                    textController: textRetryPasswordController,
                  ),

                  Visibility(
                    visible:
                        retry_password_note == null || retry_password_note == ""
                            ? false
                            : true,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 68, right: 25),
                          child: Text(
                            retry_password_note ?? "",
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
                    onTap: () {
                      // Future.delayed(const Duration(seconds: 5), () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) {
                      //         return RegistrationComplete();
                      //       },
                      //     ),
                      //   );
                      // });

                      String email = textEmailController.text;
                      String username = textUsernameController.text;
                      String phone = textPhoneController.text;
                      String password = textDesiredPasswordController.text;
                      String retryPassword = textRetryPasswordController.text;

                      int error_count = 0;

                      if (username.isEmpty) {
                        error_count += 1;
                        setState(() {
                          username_note = "Please specify Username";
                        });
                      } else {
                        setState(() {
                          username_note = "";
                        });
                      }

                      if (email.isEmpty) {
                        error_count += 1;
                        setState(() {
                          email_note = "Please specify Email Address";
                        });
                      } else {
                        String pattern =
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                        RegExp expEmail = RegExp(pattern);

                        if (!expEmail.hasMatch(email)) {
                          setState(() {
                            email_note = "Invalid Email Address Format";
                          });
                        } else {
                          setState(() {
                            email_note = "";
                          });
                        }
                      }

                      if (phone.isEmpty) {
                        error_count += 1;
                        setState(() {
                          phone_note = "Please specify Phone Number";
                        });
                      } else {
                        setState(() {
                          phone_note = "";
                        });
                      }

                      if (password.isEmpty) {
                        error_count += 1;
                        setState(() {
                          password_note = "Please specify Desired Password";
                        });
                      } else {
                        setState(() {
                          password_note = "";
                        });
                      }

                      if (retryPassword != password) {
                        if (retryPassword.length >= 8 &&
                            retryPassword.length <= 20) {
                          error_count += 1;

                          setState(() {
                            retry_password_note =
                                "Password must be atleast 8 characters long and max 20 characters";
                          });
                        } else {
                          error_count += 1;
                          setState(() {
                            retry_password_note = "Password did not matched";
                          });
                        }
                      } else {
                        if (retryPassword.isEmpty) {
                          error_count += 1;
                          setState(() {
                            retry_password_note =
                                "Please Confirm Your Password";
                          });
                        } else {
                          setState(() {
                            retry_password_note = "";
                          });
                        }
                      }

                      if (error_count < 1) {
                        registerUser(email, phone, username, password, context);
                        showLoading();
                        futureDelayed();
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
                        "Submit",
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Login();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Login Now",
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
