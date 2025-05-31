import 'package:flutter/material.dart';
import 'package:vico_grocery_store/screens/login.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});
  @override
  State<MainMenu> createState() => _mainMenuState();
}

class _mainMenuState extends State<MainMenu> {
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
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(7.5),
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
            onTap: () {
              showLogoutDialog();
            },
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width - 100,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 15),
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
                  Icon(Icons.shopping_cart_outlined),
                  Icon(Icons.qr_code_2_outlined),
                  Icon(Icons.wallet_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
