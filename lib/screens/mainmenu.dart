import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:vico_grocery_store/screens/login.dart';
import 'package:vico_grocery_store/screens/qrcode.dart';
import 'package:vico_grocery_store/screens/barcode.dart';
import 'package:vico_grocery_store/screens/checkout.dart';
import 'package:vico_grocery_store/screens/products.dart';
import 'package:vico_grocery_store/screens/profile.dart';
import 'package:vico_grocery_store/screens/cashinpage.dart';
import 'package:vico_grocery_store/screens/transaction.dart';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:vico_grocery_store/services/firebaseServices.dart';
import 'package:vico_grocery_store/services/utilCustom.dart';

import 'package:vico_grocery_store/classes/UsersClass.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});
  @override
  State<MainMenu> createState() => _mainMenuState();
}

class _mainMenuState extends State<MainMenu> {
  List<UsersClass> userData = [];
  String? username;
  String? email;
  String? phone;
  String? firebaseUID;
  int currentPageIndex = 0;
  int notifCounter = 0;

  void initState() {
    super.initState();
    getUsersDataFromProvider();
  }

  void getUsersDataFromProvider() async {
    firebaseUID = FirebaseAuth.instance.currentUser!.uid.toString();

    List<UsersClass> listUsersTemp =
        await Provider.of<FirebaseServices>(
          context,
          listen: false,
        ).getUsersData();

    int userDataLength =
        listUsersTemp
            .where((data) => data.user_id == firebaseUID)
            .toList()
            .length;

    List<UsersClass> userDataFilter =
        listUsersTemp.where((data) => data.user_id == firebaseUID).toList();

    String usernameTemp = userDataLength > 0 ? userDataFilter[0].username : "";
    String phoneTemp = userDataLength > 0 ? userDataFilter[0].phone : "";

    setState(() {
      userData = listUsersTemp;
      username = usernameTemp;
      phone = phoneTemp;
    });
  } // getUsersDataFromProvider

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Container(
                margin: const EdgeInsets.only(left: 7.5),
                child: Text(
                  "VICO Grocery Store",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              content: Container(
                height: 80,
                child: Column(
                  children: [
                    Text(
                      "Are you sure you want to Logout?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 8.5,
                              right: 15,
                              bottom: 8.5,
                              left: 15,
                            ),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 8.5,
                            right: 15,
                            bottom: 8.5,
                            left: 15,
                          ),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    FirebaseAuth.instance.signOut();
                                    return Login();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  } // showLogoutDialog

  Widget build(BuildContext context) {
    late PageController pageController = new PageController();

    firebaseUID = FirebaseAuth.instance.currentUser!.uid.toString();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Profile();
                },
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(
              top: 7.5,
              left: 15,
              right: 7.5,
              bottom: 7.5,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_2_outlined),
          ),
        ),
        title: Text(
          "VICO Grocery Store",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 15, top: 0),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(child: Icon(Icons.notifications)),
                  Visibility(
                    visible: notifCounter > 0 ? true : false,
                    child: Positioned(
                      bottom: 7,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          notifCounter.toString(),
                          style: TextStyle(fontSize: 8.5, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showLogoutDialog();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 17, top: 0),
              child: Icon(Icons.logout_outlined),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            children: [
              ListViewMain(username: username ?? "", phone: phone ?? ""),
              ListViewCart(pageControllerGet: pageController),
              Checkout(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width - 130,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 70),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 7.7,
                    blurRadius: 10.8,
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(7, 7),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(
                        0,
                        duration: Duration(microseconds: 200),
                        curve: Curves.easeOutBack,
                      );
                    },
                    child:
                        currentPageIndex != null
                            ? currentPageIndex == 0
                                ? ShaderMask(
                                  shaderCallback:
                                      (bounds) => LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.blue, Colors.black87],
                                      ).createShader(
                                        Rect.fromLTWH(
                                          0,
                                          0,
                                          bounds.width,
                                          bounds.height,
                                        ),
                                      ),
                                  child: Icon(
                                    Icons.home_filled,
                                    color: Colors.white,
                                  ),
                                )
                                : Icon(Icons.home_outlined)
                            : Icon(Icons.home_outlined),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return QRScannerScreen();
                          },
                        ),
                      );
                    },
                    child: Icon(Icons.qr_code_2_outlined),
                  ),
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    },
                    child:
                        currentPageIndex != null
                            ? currentPageIndex == 1
                                ? ShaderMask(
                                  shaderCallback:
                                      (bounds) => LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.blue, Colors.black87],
                                      ).createShader(
                                        Rect.fromLTWH(
                                          0,
                                          0,
                                          bounds.width,
                                          bounds.height,
                                        ),
                                      ),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                )
                                : Icon(Icons.shopping_cart_outlined)
                            : Icon(Icons.home_outlined),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewCart extends StatefulWidget {
  final PageController pageControllerGet;
  const ListViewCart({super.key, required this.pageControllerGet});
  @override
  State<ListViewCart> createState() => _listViewCart();
}

class _listViewCart extends State<ListViewCart> {
  void _showCartDialog(int index, PageController _pageController) {
    showDialog(
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 475,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5, bottom: 15),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  height: 175,
                                  width: MediaQuery.of(context).size.width,
                                  "https://banglasupermarket.co.uk/wp-content/uploads/2022/05/11-600x600.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                    height: 20,
                                    width: 20,
                                    child: Icon(Icons.close, size: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 15),

                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: BarcodeWidget(
                              barcode: Barcode.code128(),
                              data: "product_cart_$index",
                              width: MediaQuery.of(context).size.width,
                              height: 75,
                            ),
                          ),

                          SizedBox(height: 15),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      "Product Cart $index",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Category: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          "Vegetable",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Sold by: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          "1 Item",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Expiry Date: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          "December 2025",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Calories: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          "250 Cal",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              height: 45,
                              margin: const EdgeInsets.only(right: 2.5),
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 8,
                                left: 12,
                                right: 12,
                              ),
                              child: Text(
                                "Remove Item",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              // Navigator.pop(context);
                              // _pageController.animateToPage(
                              //   2,
                              //   duration: Duration(microseconds: 200),
                              //   curve: Curves.easeOutBack,
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Checkout();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                              height: 45,
                              margin: const EdgeInsets.only(right: 2.5),
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 8,
                                left: 20,
                                right: 20,
                              ),
                              child: Text(
                                "Add to Checkout",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  } // _showCartDialog

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Colors.transparent),
        centerTitle: true,
        title: Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 50,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(bottom: 100),
              child: ListView(
                children: List.generate(32, (index) {
                  return GestureDetector(
                    onTap: () {
                      _showCartDialog(index, widget.pageControllerGet);
                    },
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,

                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 10.10,
                            blurRadius: 15,
                            color: Colors.grey.withOpacity(0.05),
                            offset: Offset(7, 7),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black38.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: Image.network(
                                      height: 50,
                                      width: 50,
                                      "https://banglasupermarket.co.uk/wp-content/uploads/2022/05/11-600x600.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Product Cart Name $index",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text("Category: Vegetable"),
                                    ],
                                  ),
                                ],
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Text("PHP 32.00"), Text("")],
                              ),
                            ],
                          ),
                        ],
                      ),
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

class ListViewMain extends StatefulWidget {
  final String username;
  final String phone;
  const ListViewMain({super.key, required this.username, required this.phone});
  @override
  State<ListViewMain> createState() => _listViewMainState();
}

class _listViewMainState extends State<ListViewMain> {
  String? currentBalance;
  String? firebaseUID;
  int recentTransactionLimitDisplay = 3;

  void initState() {
    super.initState();

    setState(() {
      firebaseUID = FirebaseAuth.instance.currentUser!.uid.toString();
    });

    updateDisplayCurrentBalance();
  }

  void updateDisplayCurrentBalance() async {
    String currentBalanceTemp = await Provider.of<FirebaseServices>(
      context,
      listen: false,
    ).getWalletCurrentBalance(firebaseUID ?? "");

    setState(() {
      currentBalance = "PHP " + currentBalanceTemp;
    });
  } // updateDisplayCurrentBalance

  String getTransactionLabel(String transTypeId) {
    return Provider.of<UtilCustom>(
      context,
      listen: false,
    ).transactionLegend(transTypeId);
  } // getTransactionLabel

  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 10.10,
                      blurRadius: 12,
                      color: Colors.grey.withOpacity(0.1),
                      offset: Offset(4, 4),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 3.5),
                          padding: const EdgeInsets.only(
                            left: 12.5,
                            right: 12.5,
                            top: 2.5,
                            bottom: 2.5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.blueAccent, Colors.blue],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.workspace_premium_outlined,
                                color: Colors.white,
                                size: 8,
                              ),
                              SizedBox(width: 3.5),
                              Text(
                                "Premium",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Welcome ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 3),
                            Text(
                              widget.username,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Transaction();
                                },
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "View Transactions",
                                style: TextStyle(fontSize: 10),
                              ),
                              Icon(Icons.arrow_right_outlined),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blueAccent, Colors.black87],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 35),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentBalance ?? "PHP 0.0",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Average Spending: PHP 690.32/Day",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.money,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  SizedBox(width: 2),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CashInPage(
                                              sourceAccountName:
                                                  widget.username,
                                              sourceAccountNumber: widget.phone,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Cash-in",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.send_outlined,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "Send Money",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.history_outlined,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "View History",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BarcodeScannerScreen();
                },
              ),
            );
          },
          child: Container(
            height: 135,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 7.7,
                  blurRadius: 10.8,
                  color: Colors.grey.withOpacity(0.2),
                  offset: Offset(7, 7),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Find any product from any VICO Grocery Store and",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: "Scan the Barcode",
                    width: MediaQuery.of(context).size.width,
                    height: 75,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          height: 280,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListView(
            scrollDirection: Axis.horizontal,

            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Products();
                      },
                    ),
                  );
                },
                child: Container(
                  width: 135,
                  height: 225,
                  margin: const EdgeInsets.only(right: 10, bottom: 15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 17.7,
                        spreadRadius: 5,
                        offset: Offset(4, 4),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.only(
                          top: 45,
                          bottom: 45,
                          left: 35,
                          right: 35,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Icon(
                          Icons.shopping_cart_checkout_sharp,
                          size: 55,
                        ),
                      ),

                      SizedBox(height: 8),
                      Text(
                        "View Products",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Delivery products\nto your home",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 135,
                height: 225,
                margin: const EdgeInsets.only(right: 10, bottom: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 17.7,
                      spreadRadius: 5,
                      offset: Offset(4, 4),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.only(
                        top: 45,
                        bottom: 45,
                        left: 35,
                        right: 35,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Icon(Icons.energy_savings_leaf, size: 55),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Veggies Daily",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Get home\nveggies everyday",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 135,
                height: 225,
                margin: const EdgeInsets.only(right: 10, bottom: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 17.7,
                      spreadRadius: 5,
                      offset: Offset(4, 4),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.only(
                        top: 45,
                        bottom: 45,
                        left: 35,
                        right: 35,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Icon(Icons.trending_up_outlined, size: 55),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Trending Products",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Get the latest\nproducts here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                spreadRadius: 7.7,
                blurRadius: 10.8,
                color: Colors.grey.withOpacity(0.2),
                offset: Offset(7, 7),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Container(
                height: 305,
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream:
                      Provider.of<FirebaseServices>(context, listen: false)
                          .getTransactionStream(
                            recentTransactionLimitDisplay,
                            firebaseUID ?? "",
                          )
                          .asStream(),
                  builder: (contextBuild, snapshot) {
                    int dataLength = snapshot.data!.length;

                    if (snapshot.hasError) {
                      return Center(child: Text("No data available"));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return dataLength > 0
                        ? ListView.builder(
                          itemCount: dataLength,
                          itemBuilder: (context, index) {
                            final transactionData = snapshot.data;
                            String receiptId =
                                transactionData![index].receipt_id;
                            String transactionId =
                                transactionData![index].user_transaction_id;
                            String paymentMerchant =
                                transactionData![index].payment_provider_name;
                            String transactionType =
                                transactionData![index].transaction_type;
                            String amount = transactionData![index].amount;
                            String dateTime = transactionData![index].date_time;
                            String transactionTypeLabel =
                                getTransactionLabel(transactionType) +
                                " ($paymentMerchant)";

                            return Container(
                              height: 80,
                              margin: const EdgeInsets.only(
                                top: 10,
                                bottom: 5,
                                left: 10,
                                right: 10,
                              ),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 7.7,
                                    blurRadius: 10.8,
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: Offset(7, 7),
                                  ),
                                ],
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transactionTypeLabel,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Receipt ID: $receiptId",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        dateTime,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  (amount != "")
                                      ? Text(
                                        "PHP " +
                                            double.parse(
                                              amount,
                                            ).toStringAsFixed(2),
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                        ),
                                      )
                                      : Text("--"),
                                ],
                              ),
                            );
                          },
                        )
                        : Center(child: Text("No data available"));
                  },
                ),
              ),
              SizedBox(height: 2.5),
              Text("View All Transactions", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
