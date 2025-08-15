import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sinrorobotics_machine_test/utils/routes.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
          () {
        Navigator.pushReplacementNamed(context, Routes.productlisting);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.red,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/images/bubbles.json",
                  width: screenWidth * 0.5,
                  height: screenheight * 0.17,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
