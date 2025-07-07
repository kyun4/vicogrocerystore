import 'package:flutter/material.dart';
import 'package:vico_grocery_store/screens/mainmenu.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class CashInSummaryStatus extends StatefulWidget {
  final String merchant;
  final String amount;
  final String account_name;
  final String account_number;
  const CashInSummaryStatus({
    super.key,
    required this.merchant,
    required this.amount,
    required this.account_name,
    required this.account_number,
  });

  State<CashInSummaryStatus> createState() => _cashInSummaryStatusState();
}

class _cashInSummaryStatusState extends State<CashInSummaryStatus> {
  String dateTimeNow = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_left_outlined, color: Colors.transparent),
        actions: [
          GestureDetector(
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
            child: Container(
              margin: const EdgeInsets.only(top: 10, right: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: Icon(Icons.close_outlined, size: 15),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Cash-in Payment is processing from",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 15),

              Lottie.asset(
                "assets/json_animations/loading_clock_1.json",
                height: 85,
                width: 85,
                fit: BoxFit.contain,
              ),

              Text(
                widget.merchant,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 7.5,
                  right: 7.5,
                  top: 4,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Text(
                  "- PHP" + double.parse(widget.amount).toStringAsFixed(2),
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(15),

                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7.7,
                      spreadRadius: 7.7,
                      offset: Offset(4, 4),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Account Information"),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Source Account Name: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          widget.account_name,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Source Account Number: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          widget.account_number,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Destination Merchant: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "VICO Grocery Store",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Destination Account Name: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Admin",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Destination Account Number: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "09326969321",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date and Time Processed:",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          dateTimeNow,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              GestureDetector(
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
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent],
                    ),
                  ),
                  child: Text(
                    "Done",

                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
