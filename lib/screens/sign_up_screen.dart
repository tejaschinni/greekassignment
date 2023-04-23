import 'package:flutter/material.dart';
import 'package:greekassignment/models/userModel.dart';
import 'package:greekassignment/saveData.dart';
import 'package:greekassignment/screens/home_screen.dart';
import 'package:greekassignment/widgets/customTextField.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String dropdownValue = 'Select Your Profession';

  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    getuser();
  }

  void getuser() async {
    final bo = Data.getData();
    bo.values.forEach((element) {
      print("========================");
      print(element.key.toString());
      print(element.email);
      print(element.password);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                child: Image.asset(
                  "assets/login.jpg",
                  scale: 5,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 1,
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
                              "Create account",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              hidde: false,
                              icondata: Icons.person,
                              controler: nameController,
                              labeltext: 'Name',
                              hintText: "Enter Your Name",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Name';
                                }
                                return null;
                              }),
                          CustomTextField(
                              hidde: false,
                              icondata: Icons.email,
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
                              hidde: false,
                              icondata: Icons.phone,
                              controler: phoneController,
                              labeltext: 'Phone',
                              hintText: "Enter Your Hone Number",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Pawword';
                                }
                                if (value.length != 10) {
                                  return 'Enter valid phone number ';
                                }
                                return null;
                              }),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: Colors.grey)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: DropdownButton<String>(
                              dropdownColor:
                                  Colors.grey, //dropdown background color
                              underline: Container(
                                margin: const EdgeInsets.all(30),
                              ), //remove underline
                              isExpanded: true,
                              value: dropdownValue,
                              icon: const Padding(
                                  //Icon at tail, arrow bottom is default icon
                                  padding: EdgeInsets.only(left: 40),
                                  child: Icon(Icons.arrow_circle_down_sharp)),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),

                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Select Your Profession',
                                'Teacher',
                                'Engineer',
                                'Designer',
                                'Lawyer',
                                'Actor',
                                'App Developer',
                                'mearn'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                );
                              }).toList(),
                            ),
                          ),
                          CustomTextField(
                              hidde: true,
                              icondata: Icons.key,
                              controler: passController,
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
                          CustomTextField(
                              hidde: true,
                              icondata: Icons.key,
                              controler: confirmController,
                              labeltext: 'Re-Enter Passwor',
                              hintText: "Enter Your Password Again",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Password';
                                }
                                if (value.length < 6) {
                                  return 'Password Should be gearter then 5';
                                }
                                if (value != passController.text.toString()) {
                                  return 'Password Not match';
                                }
                                return null;
                              }),
                          Row(
                            children: [
                              Checkbox(
                                value: !_isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                              Text("I accept terms and condition ")
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print(dropdownValue.toString());
                                if (dropdownValue != "Select Your Profession") {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    final data = User(
                                        name: nameController.text.toString(),
                                        email: emailController.text.toString(),
                                        password:
                                            passController.text.toString(),
                                        phone: phoneController.text.toString(),
                                        profession: dropdownValue.toString());

                                    final box = Data.getData();
                                    box.add(data);
                                    data.save().then((value) {});
                                    box.values.forEach((element) {
                                      if (emailController.text.toString() ==
                                          element.email.toString()) {
                                        print(element.key.toString());
                                        save(emailController.text.toString());
                                      }
                                    });

                                    nameController.clear();
                                    emailController.clear();
                                    passController.clear();
                                    confirmController.clear();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Select the Profiession")));
                                  }
                                }
                              },
                              child: const Text("Create account"))
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void save(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final box = Data.getData();
    box.values.forEach((element) async {
      if (email.toString() == element.email.toString()) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("key", element.key.toString());
        prefs.setBool("islogin", true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }
}
