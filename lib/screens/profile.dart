import 'dart:developer';

import 'package:flint/screens/likes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void doSignOut() async {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
            title: Center(child: CircularProgressIndicator.adaptive())));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    Future.delayed(const Duration(milliseconds: 1000), () {
      log('successfully signed out');
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).popAndPushNamed('/signin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Dismissible(
                      dragStartBehavior: DragStartBehavior.start,
                      direction: DismissDirection.endToStart,
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: const Key("signout"),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('dismissed')));
                      },
                      confirmDismiss: (direction) async {
                        // late bool proceed;
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Hold up'),
                                content:
                                    const Text('You are about to sign out'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      doSignOut();
                                      // proceed = true;
                                    },
                                    child: const Text('Sign Out'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            });
                        return false;
                        // if (direction == DismissDirection.endToStart) {
                        //   /// edit item
                        //   return false;
                        // }
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        color: Colors.red,
                        child: const Text(
                          "confirm",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade900,
                              child: const Text('AH'),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "abadisurio",
                                  style: TextStyle(
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Liked these movies",
                                  style: TextStyle(color: Colors.grey.shade900),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              "\u{25C0} Sign Out",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      )))),
          const SliverFillRemaining(child: LikesPage())
        ],
      ),
    );
  }
}
