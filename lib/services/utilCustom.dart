import 'package:flutter/material.dart';

class UtilCustom with ChangeNotifier {
  String transactionLegend(String transactionId) {
    String label = "";

    switch (transactionId) {
      case "1":
        label = "In-store Purchase";
        break;
      case "2":
        label = "Cash-In thru E-wallet/Online Bank";
        break;
      case "3":
        label = "Cash-In thru Cashier";
        break;
      default:
        label = "Transaction";
        break;
    }

    return label;
  }
}
