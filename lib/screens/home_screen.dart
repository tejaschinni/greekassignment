import 'package:flutter/material.dart';
import 'package:greekassignment/api_call.dart';
import 'package:greekassignment/models/move_model.dart';
import 'package:greekassignment/screens/sign_in_screen.dart';
import 'package:greekassignment/widgets/movieite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieModel? movies;
  String dropdownValue = "ALL";
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData("all");
  }

  void getData(String lang) async {
    try {
      var result = await APICall().getAPIData(lang);
      setState(() {
        movies = MovieModel.fromJson(result);
        isLoaded = true;
      });
    } catch (e) {}
    print(movies!.result.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      drawer: Drawer(
          child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text("Company Info"),
              trailing: const Icon(Icons.info),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Company Information'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Company: Geeksynergy Technologies Pvt Ltd'),
                            Text('Address: Sanjayanagar, Bengaluru-56'),
                            Text('Phone: XXXXXXXXX09'),
                            Text('Email: XXXXXX@gmail.com'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: const Text("Logout"),
              trailing: const Icon(Icons.logout),
              onTap: () {
                logout();
              },
            )
          ],
        ),
      )),
      body: isLoaded
          ? Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.grey)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: DropdownButton<String>(
                    hint: const Text("Langauage"),
                    dropdownColor: Colors.white,
                    underline: Container(
                      margin: const EdgeInsets.all(30),
                    ),
                    isExpanded: true,
                    value: dropdownValue,
                    icon: const Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Icon(Icons.arrow_circle_down_sharp)),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                      getData(dropdownValue.toLowerCase());
                    },
                    items: <String>['ALL', 'kannada', 'Hindi']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: movies!.result.length,
                        itemBuilder: (context, index) {
                          movies!.result.sort((a, b) {
                            return b.voting.compareTo(a.voting);
                          });
                          DateTime date = DateTime.fromMillisecondsSinceEpoch(
                              int.parse(movies!.result[index].releasedDate
                                  .toString()));
                          return MovieItem(result: movies!.result[index]);
                        }))
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    ));
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("key");
    prefs.setBool("islogin", false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }
}
