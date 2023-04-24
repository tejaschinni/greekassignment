import 'package:flutter/material.dart';
import 'package:greekassignment/saveData.dart';
import 'package:greekassignment/screens/home_screen.dart';
import 'package:greekassignment/screens/sign_up_screen.dart';
import 'package:greekassignment/widgets/customTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              child: Image.asset("assets/login.jpg"),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Card(
                  elevation: 50,
                  color: Colors.grey,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            "Login to Your account",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            hidde: false,
                            icondata: Icons.email,
                            type: TextInputType.text,
                            controler: emailController,
                            labeltext: 'Email',
                            hintText: "Enter Your Email",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            }),
                        CustomTextField(
                            hidde: true,
                            icondata: Icons.key,
                            controler: passController,
                            type: TextInputType.text,
                            labeltext: 'Password',
                            hintText: "Enter Your Password",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Pawword';
                              }
                              if (value.length < 6) {
                                return 'Password Should be gearter then 5';
                              }
                              return null;
                            }),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpScreen()));
                                  },
                                  child: Text("Create Account")),
                              const Text(
                                "Forgot Password",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                login(emailController.text.toString(),
                                    passController.text.toString());
                                emailController.clear();
                                passController.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Invalid Email & Password")));
                              }
                            },
                            child: const Text("Login"))
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    ));
  }

  void login(String email, String password) async {
    final box = Data.getData();
    box.values.forEach((element) async {
      if (email.toString() == element.email.toString() &&
          password.toString() == element.password.toString()) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("key", element.key.toString());
        prefs.setBool("islogin", true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }
}
