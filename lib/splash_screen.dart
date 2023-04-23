import 'package:flutter/material.dart';
import 'package:greekassignment/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLogin();
  }

  void checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? check = prefs.getBool("islogin");

    if (check == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignInScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
