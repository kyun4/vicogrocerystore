import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vico_grocery_store/screens/register.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _splashState();
}

class _splashState extends State<Splash> {
  final PageController _pageController = new PageController();

  List<Widget> _pages = [SplashOne(), SplashTwo(), SplashThree()];

  int currentPage = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          children: _pages,
        ),
      ),
    );
  }
}

class SplashOne extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset(
                'assets/json_animations/store-1.json',
                height: MediaQuery.of(context).size.height - 400,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5, left: 25, right: 25),
              child: Text(
                "Welcome New Suki!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: Text(
                "With VICO Grocery Store\nEvery purchase is Easy and Convenient",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width - 275,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 7,
                    width: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.lightBlue,
                    ),
                  ),

                  Container(
                    height: 7,
                    width: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),

                  Container(
                    height: 7,
                    width: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} // SplashOne

class SplashTwo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset(
                'assets/json_animations/store-4.json',
                height: MediaQuery.of(context).size.height - 400,
                width: MediaQuery.of(context).size.width - 200,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5, left: 25, right: 25),
              child: Text(
                "Shop All Day!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: Text(
                "You can now enjoy 24/7 shopping,\nWe have surveillance camera for secure shopping",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width - 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 7,
                    width: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),

                  Container(
                    height: 7,
                    width: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.lightBlue,
                    ),
                  ),

                  Container(
                    height: 7,
                    width: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} // SplashTwo

class SplashThree extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset(
                'assets/json_animations/store-5.json',
                height: MediaQuery.of(context).size.height - 400,
                width: MediaQuery.of(context).size.width - 225,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5, left: 25, right: 25),
              child: Text(
                "Enjoy your Daily Purchases!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: Text(
                "You may now continue shopping\nAfter easy registration steps",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width - 275,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 7,
                    width: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),

                  Container(
                    height: 7,
                    width: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),

                  Container(
                    height: 7,
                    width: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.lightBlue,
                    ),
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
                      return Register();
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                  left: 35,
                  right: 35,
                  top: 15,
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.lightBlue,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  "Register Now",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} // SplashThree
