import 'package:flutter/material.dart';
import 'package:vico_grocery_store/screens/mainmenu.dart';
import 'package:barcode_widget/barcode_widget.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});
  @override
  State<Checkout> createState() => _checkOutState();
}

class _checkOutState extends State<Checkout> {
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
        title: Text("Checkout"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: "checkout_1",
              width: MediaQuery.of(context).size.width,
              height: 125,
            ),
            SizedBox(height: 10),
            Center(child: Text("Show this QR Code to Cashier")),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height - 250,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: List.generate(5, (index) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product Name $index",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Vegetables",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "PHP 1200.00",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      " x 1",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text("PHP 1200.00"),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
