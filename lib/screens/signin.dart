import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void registerUser() async {
    // void getFilteredMovie() async {
    String url = 'http://10.0.2.2:3000/api/signin';
    Map<String, String> body = {
      'username': usernameController.text,
      'password': passwordController.text,
    };
    var client = http.Client();
    dev.log("test");
    try {
      final response = await client.post(Uri.parse(url), body: body);
      final bodyResponse = jsonDecode(response.body);
      dev.log(bodyResponse.toString());
      dev.log(bodyResponse["message"].toString());
      if (bodyResponse["status"] == "success") {
        // dev.log(bodyResponse["data"]["token"].toString());
        // obtain shared preferences
        final prefs = await SharedPreferences.getInstance();
        // set value
        final token = bodyResponse["data"]["token"];
        dev.log("wkwk " + token);
        prefs.setString('authToken', token);
        Navigator.popAndPushNamed(context, '/root');
      }

      // if (bodyResponse["data"]) {
      //   dev.log(bodyResponse["status"].toString());
      // } else {
      //   final snackBar = SnackBar(
      //     content: Text(bodyResponse["message"]),
      //   );
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }

      // return MovieWithDetail.fromJson(jsonDecode(response.body));
    } catch (err) {
      // log(err.toString());
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
              child: const Text('Sign in')),
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
                child: const Text('Sign In'),
                onPressed: () {
                  dev.log(usernameController.text);
                  dev.log(passwordController.text);
                  registerUser();
                },
              )),
          Row(
            children: <Widget>[
              const Text('Don\'t have an account?'),
              TextButton(
                child: const Text(
                  'Register',
                ),
                onPressed: () {
                  //signup screen
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
