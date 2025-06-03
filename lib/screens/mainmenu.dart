import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:vico_grocery_store/screens/login.dart';
import 'package:vico_grocery_store/screens/qrcode.dart';
import 'package:vico_grocery_store/screens/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:vico_grocery_store/services/firebaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vico_grocery_store/classes/UsersClass.dart';
import 'package:provider/provider.dart';

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

    setState(() {
      userData = listUsersTemp;
      username = usernameTemp;
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
        leading: Container(
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
        title: Text(
          "VICO Grocery Store",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 15, top: 0),
              child: Icon(Icons.notifications),
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

            children: [ListViewMain(username: username ?? ""), ListViewCart()],
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
                    child: Icon(Icons.home_filled),
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
                    child: Icon(Icons.shopping_cart_outlined),
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
  const ListViewCart({super.key});
  @override
  State<ListViewCart> createState() => _listViewCart();
}

class _listViewCart extends State<ListViewCart> {
  void _showCartDialog(int index) {
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
                height: 350,
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
                                  height: 177,
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
                            margin: const EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                              height: 35,
                              margin: const EdgeInsets.only(right: 2.5),
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                                left: 12,
                                right: 12,
                              ),
                              child: Text(
                                "Remove",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            height: 35,

                            margin: const EdgeInsets.only(right: 2.5),
                            padding: const EdgeInsets.only(
                              top: 8,
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
                      _showCartDialog(index);
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
  const ListViewMain({super.key, required this.username});
  @override
  State<ListViewMain> createState() => _listViewMainState();
}

class _listViewMainState extends State<ListViewMain> {
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
                        Row(
                          children: [
                            Text(
                              "View Transactions",
                              style: TextStyle(fontSize: 10),
                            ),
                            Icon(Icons.arrow_right_outlined),
                          ],
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
                          "PHP 32,000.00",
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
                                  Text(
                                    "Cash-in",
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
                child: ListView(
                  children: List.generate(32, (index) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Transaction $index"),
                              Text(
                                "Receipt ID: 010101001010101001",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "June 1, 2025 8:32PM",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "PHP 1,000.00",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    );
                  }),
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
