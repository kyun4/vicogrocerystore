import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vico_grocery_store/services/transaction_bloc.dart';
import 'package:vico_grocery_store/screens/mainmenu.dart';

import 'package:vico_grocery_store/services/firebaseServices.dart';
import 'package:vico_grocery_store/services/utilCustom.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});
  State<Transaction> createState() => _transactionState();
}

class _transactionState extends State<Transaction> {
  String? firebaseUID;

  void initState() {
    super.initState();

    setState(() {
      firebaseUID = FirebaseAuth.instance.currentUser!.uid.toString();
    });
  }

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
        title: Text("Transactions"),
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream:
                Provider.of<FirebaseServices>(
                  context,
                  listen: false,
                ).getTransactionStream(0, firebaseUID ?? "").asStream(),
            builder: (context, snapshot) {
              final data = snapshot.data;

              if (snapshot.hasError) {
                return Center(child: Text("Retrieving Transactions Failed"));
              }

              if (!snapshot.hasData) {
                return Center(child: Text("No transactions available"));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  String transactionType = data[index].transaction_type;
                  String transactionTypeLabel = Provider.of<UtilCustom>(
                    context,
                    listen: false,
                  ).transactionLegend(transactionType);
                  double amount = double.parse(data[index].amount);
                  String price = amount.toStringAsFixed(2);
                  String dateTime = data[index].date_time;
                  return Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.price_change, color: Colors.white),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$transactionTypeLabel",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("PHP $price"),
                            Text("$dateTime", style: TextStyle(fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
