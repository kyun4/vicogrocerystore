import 'package:flutter/material.dart';
import 'package:vico_grocery_store/screens/mainmenu.dart';
import 'package:vico_grocery_store/components/textFieldCashIn.dart';
import 'package:vico_grocery_store/services/firebaseServices.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<String> paymentMethods = ["Maya", "GCash", "BPI", "GoTyme"];

class CashInPage extends StatefulWidget {
  const CashInPage({super.key});

  State<CashInPage> createState() => _cashInPageState();
}

class _cashInPageState extends State<CashInPage> {
  TextEditingController amountController = new TextEditingController();

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
                height: 200,
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
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: Text(
                        "Amount",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextFieldCashIn(
                      hintTextLabel: "0.0",
                      textController: amountController,
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
                          String firebaseUID =
                              FirebaseAuth.instance.currentUser!.uid;
                          Provider.of<FirebaseServices>(
                            context,
                            listen: false,
                          ).addTransaction(
                            firebaseUID,
                            "2",
                            amountController.text,
                            "",
                            paymentMethods[index],
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MainMenu();
                              },
                            ),
                          );
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
