import 'package:flutter/material.dart';
import 'package:vico_grocery_store/classes/UsersClass.dart';
import 'package:vico_grocery_store/classes/ProductsClass.dart';
import 'package:vico_grocery_store/classes/WalletClass.dart';
import 'package:vico_grocery_store/classes/TransactionClass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class FirebaseServices with ChangeNotifier {
  List<UsersClass> listUserData = [];
  List<UsersClass> get _listUserData => listUserData;
  List<ProductsClass> listProductData = [];
  List<ProductsClass> get _listProductData => listProductData;

  void addUser(String user_id, String email, String phone, String username) {
    String date_time_registered = DateFormat(
      "yyyy-MM-dd hh:mm:ss",
    ).format(DateTime.now());
    String url =
        "https://vicostore-fa07b-default-rtdb.firebaseio.com/" +
        "users/$user_id.json";

    Random randomNumbers = new Random();
    int randomNum = 100000 + randomNumbers.nextInt(900000);

    Uuid uuidVal = new Uuid();
    String uniqueQrCodeID = uuidVal.v4();

    try {
      final response = http.put(
        Uri.parse(url),
        body: json.encode({
          "email": email,
          "phone": phone,
          "username": username,
          "user_id": user_id,
          "date_time_registered": date_time_registered,
          "firstname": "",
          "lastname": "",
          "middlename": "",
          "address": "",
          "otp": randomNum.toString(),
          "qrcode": uniqueQrCodeID,
        }),
      );
    } catch (error) {
      throw error;
    }
  } // addUser

  void addTransaction(
    String user_id,
    String user_role,
    String amount,
    String payment_method,
    String payment_provider_name,
  ) async {
    final UID = new Uuid();

    String datetimestamp = DateFormat("yyyyMMddhhmmss").format(DateTime.now());
    String user_transaction_id = UID.v4();
    String vat_amount = "";
    String vat_percentage = "";
    String processing_fee = "";
    String receiptId =
        "vicogrocerystore_" +
        datetimestamp +
        DateTime.now().millisecond.toString();
    String datetimenow = DateFormat(
      "yyyy-MM-dd hh:mm:ss",
    ).format(DateTime.now());

    try {
      String url =
          "https://vicostore-fa07b-default-rtdb.firebaseio.com/" +
          "user_transaction/$user_transaction_id.json";
      final response = await http.put(
        Uri.parse(url),
        body: json.encode({
          "receipt_id": receiptId,
          "user_id": user_id,
          "user_id_role": user_role,
          "user_transaction_id": user_transaction_id,
          "amount": amount,
          "date_time": datetimenow,
          "grocery_fee": "",
          "payment_method": payment_method,
          "payment_provider_name": payment_provider_name,
          "processing_fee": processing_fee,
          "purchase_type":
              "1", // 1 - Over the Counter/Cashier, 2 - Delivery/Remotely, 3 - Pickup
          "remarks": "",
          "status": "0",
          "transaction_type": "2",
          "vat_amount": vat_amount,
          "vat_percentage": vat_percentage,
          "approved_by": "",
          "approved_by_role": "",
          "date_time_approved": "",
        }),
      );
    } catch (error) {
      throw error;
    }
  } // addTransaction

  Future<List<TransactionClass>> getTransactionStream(
    int limit,
    String firebaseUID,
  ) async {
    List<TransactionClass> listTransaction = [];

    String url =
        "https://vicostore-fa07b-default-rtdb.firebaseio.com/user_transaction.json";

    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null || response.body.isEmpty) {
        return [];
      }

      extractedData.forEach((key, json) {
        String userID = json['user_id'] ?? "";
        if (firebaseUID == userID) {
          listTransaction.add(
            new TransactionClass(
              user_transaction_id: json['user_transaction_id'] ?? "",
              user_id: userID,
              user_id_role: json['user_id_role'] ?? "",
              receipt_id: json['receipt_id'] ?? "",
              transaction_type: json['transaction_type'] ?? "",
              status: json['status'] ?? "",
              vat_amount: json['vat_amount'] ?? "",
              vat_percentage: json['vat_percentage'] ?? "",
              date_time: json['date_time'] ?? "",
              date_time_approved: json['date_time_approved'] ?? "",
              amount: json['amount'] ?? "",
              approved_by: json['approved_by'] ?? "",
              approved_by_role: json['approved_by_role'] ?? "",
              grocery_fee: json['grocery_fee'] ?? "",
              payment_method: json['payment_method'] ?? "",
              payment_provider_name: json['payment_provider_name'] ?? "",
              processing_fee: json['processing_fee'] ?? "",
              purchase_type: json['purchase_type'] ?? "",
              remarks: json['remarks'] ?? "",
            ),
          );
        }
      });
    } catch (error) {
      throw error;
    }

    listTransaction = listTransaction.take(limit).toList();

    return listTransaction;
  } // getTransactionStream

  Future<String> getWalletCurrentBalance(String firebaseUID) async {
    String currentBalance = "";

    List<WalletClass> walletRecord = [];

    String url =
        "https://vicostore-fa07b-default-rtdb.firebaseio.com/user_wallet.json";

    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null || response.body.isEmpty) {
        return "";
      }

      extractedData.forEach((key, json) {
        if (firebaseUID == key) {
          walletRecord.add(
            WalletClass(
              user_id: key,
              current_balance: json['current_balance'] ?? "",
              date_time_last_updated: json['date_time_last_updated'] ?? "",
            ),
          );
        }
      });

      currentBalance = walletRecord.toList()[0].current_balance;
    } catch (error) {
      throw error;
    }

    return currentBalance;
  } // getWalletCurrentBalance

  void updateWallet(
    String firebaseUID,
    String previousCurrentBalance,
    String amountToAdd,
  ) async {
    double prevBalance = double.parse(previousCurrentBalance);
    double newBalance = double.parse(amountToAdd) + prevBalance;
    String currentBalance = newBalance.toStringAsFixed(2);
    String date_time_last_updated = DateFormat(
      "YYYY-mm-dd hh:mm:ss",
    ).format(DateTime.now());

    try {
      String url =
          "https://vicostore-fa07b-default-rtdb.firebaseio.com/" +
          "user_wallet/$firebaseUID.json";

      final response = await http.put(
        Uri.parse(url),
        body: json.encode({
          "user_id": firebaseUID,
          "current_balance": currentBalance,
          "date_time_last_updated": date_time_last_updated,
        }),
      );
    } catch (error) {
      throw error;
    }
  } // updateWallet

  Future<List<UsersClass>> getUsersData() async {
    List<UsersClass> listData = [];
    String url =
        "https://vicostore-fa07b-default-rtdb.firebaseio.com/" + "users.json";

    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null || response.body.isEmpty) {
        return [];
      }

      extractedData.forEach((key, json) {
        listData.add(
          UsersClass(
            user_id: json['user_id'] ?? "",
            username: json['username'] ?? "",
            firstname: json['firstname'] ?? "",
            middlename: json['middlename'] ?? "",
            lastname: json['lastname'] ?? "",
            phone: json['phone'] ?? "",
            address: json['address'] ?? "",
            email: json['email'] ?? "",
            otp: json['otp'] ?? "",
            qrcode: json['qrcode'] ?? "",
            date_time_registered: json['date_time_registered'] ?? "",
          ),
        );

        listUserData = listData;

        notifyListeners();
      });
    } catch (error) {
      throw error;
    }

    return listData;
  } // getUsersData

  Future<List<ProductsClass>> getProductsData() async {
    List<ProductsClass> listProducts = [];
    String url =
        "https://vicostore-fa07b-default-rtdb.firebaseio.com/" +
        "products.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null || response.body.isEmpty) {
        return [];
      } else {
        extractedData.forEach((key, json) {
          listProducts.add(
            ProductsClass(
              product_id: key,
              product_name: json['product_name'],
              price: json['price'],
              category_id: json['category_id'],
              barcode: json['barcode'],
              sold_by_quantity: json['sold_by_quantity'],
              sku: json['sku'],
              added_by: json['added_by'],
              date_time_added: json['date_time_added'],
              last_updated_by: json['last_updated_by'],
              last_date_time_updated: json['date_time_last_updated'],
              url_image: json['url_image'],
              current_stock: json['current_stock'],
              user_quantity_limit: json['user_quantity_limit'],
            ),
          );
        });
      }
    } catch (error) {
      throw error;
    }

    return listProducts;
  }
}
