import 'package:flutter/material.dart';
import 'package:vico_grocery_store/classes/UsersClass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class FirebaseServices with ChangeNotifier {
  List<UsersClass> listUserData = [];
  List<UsersClass> get _listUserData => listUserData;

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
    String uniqueQrCodeID = uuidVal.toString();

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
}
