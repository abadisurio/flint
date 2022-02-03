import 'dart:convert';
import 'dart:developer';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void registerUser() async {
    // void getFilteredMovie() async {
    String url = 'http://10.0.2.2:3000/api/register';
    Map<String, String> body = {
      'username': usernameController.text,
      'password': passwordController.text,
    };
    var client = http.Client();
    dev.log("test");
    try {
      final response = await client.post(Uri.parse(url), body: body);
      final bodyResponse = jsonDecode(response.body);
      dev.log(bodyResponse["status"].toString());
      if (bodyResponse["data"]) {
        dev.log(bodyResponse["status"].toString());
        Navigator.popAndPushNamed(context, '/signin');
        // obtain shared preferences
        // final prefs = await SharedPreferences.getInstance();
        // // set value
        // prefs.setInt('userToken', counter);
      } else {
        final snackBar = SnackBar(
          content: Text(bodyResponse["message"]),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      // return MovieWithDetail.fromJson(jsonDecode(response.body));
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 70),
              child:
                  Text('Flint', style: Theme.of(context).textTheme.headline1)),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text('Register')),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () {
                  log(usernameController.text);
                  log(passwordController.text);
                  registerUser();
                },
              )),
          Row(
            children: <Widget>[
              const Text('Already have an account?'),
              TextButton(
                child: const Text(
                  'Sign in',
                ),
                onPressed: () {
                  //signup screen
                  Navigator.popAndPushNamed(context, '/signin');
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
