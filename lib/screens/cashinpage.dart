import 'package:flutter/material.dart';
import 'package:vico_grocery_store/screens/mainmenu.dart';
import 'package:vico_grocery_store/screens/CashInSummaryStatus.dart';
import 'package:vico_grocery_store/components/textFieldCashIn.dart';
import 'package:vico_grocery_store/services/firebaseServices.dart';

import 'package:provider/provider.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

List<String> paymentMethods = ["Maya", "GCash", "BPI", "GoTyme"];

class CashInPage extends StatefulWidget {
  final String sourceAccountName;
  final String sourceAccountNumber;
  const CashInPage({
    super.key,
    required this.sourceAccountName,
    required this.sourceAccountNumber,
  });

  State<CashInPage> createState() => _cashInPageState();
}

class _cashInPageState extends State<CashInPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController amountController = new TextEditingController();
  String? currentBalance;
  String? firebaseUID;
  String? amountStatus;

  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  void initState() {
    super.initState();
    setState(() {
      firebaseUID = FirebaseAuth.instance.currentUser!.uid;
    });
    updateDisplayCurrentBalance();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween(begin: 0.0, end: 8.0)
      .chain(CurveTween(curve: Curves.elasticIn))
      .animate(_controller)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    amountController.addListener(() {
      if (amountController.text != "") {
        setState(() {
          amountStatus = "";
        });
      }
    });
  }

  void startShake() {
    _controller.forward(from: 0);
  } // startShake

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateDisplayCurrentBalance() async {
    String currentBalanceTemp = await Provider.of<FirebaseServices>(
      context,
      listen: false,
    ).getWalletCurrentBalance(firebaseUID ?? "");

    setState(() {
      currentBalance = currentBalanceTemp;
    });
  } // updateDisplayCurrentBalance

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MainMenu();
                },
              ),
            );
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("Cash-In"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 210,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7.7,
                      spreadRadius: 10,
                      color: Colors.grey.withOpacity(0.1),
                      offset: Offset(4, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        "Amount",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    AnimatedBuilder(
                      animation: _offsetAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(sin(_offsetAnimation.value) * 10, 0),
                          child: child,
                        );
                      },
                      child: TextFieldCashIn(
                        hintTextLabel: "0.0",
                        textController: amountController,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        amountStatus ?? "",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 350,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 12.5),
                  itemCount: paymentMethods.length,
                  itemBuilder:
                      (context, index) => GestureDetector(
                        onTap: () {
                          var error = 0;

                          if (amountController.text == "") {
                            error += 1;
                            setState(() {
                              amountStatus = "Please specify amount";
                            });
                          } else {
                            if (double.parse(amountController.text) < 1) {
                              error += 1;
                              setState(() {
                                amountStatus = "Enter valid amount more than 0";
                              });
                            }
                          }

                          if (error > 0) {
                            startShake();
                          } else {
                            Provider.of<FirebaseServices>(
                              context,
                              listen: false,
                            ).addTransaction(
                              firebaseUID ?? "",
                              "2",
                              amountController.text,
                              "",
                              paymentMethods[index],
                            );

                            Provider.of<FirebaseServices>(
                              context,
                              listen: false,
                            ).updateWallet(
                              firebaseUID ?? "",
                              currentBalance ?? "0",
                              amountController.text,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CashInSummaryStatus(
                                    merchant: paymentMethods[index],
                                    amount: amountController.text,
                                    account_name: widget.sourceAccountName,
                                    account_number: widget.sourceAccountNumber,
                                  );
                                },
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 75,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 8.8,
                                blurRadius: 10,
                                color: Colors.grey.withOpacity(0.2),
                                offset: Offset(7, 7),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [Text(paymentMethods[index])]),
                              Icon(Icons.arrow_right_outlined),
                            ],
                          ),
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
