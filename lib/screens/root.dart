import 'package:flint/screens/explore.dart';
import 'package:flint/screens/match.dart';
import 'package:flint/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flint/pages/account_page.dart';
// import 'package:flint/pages/chat_page.dart';
// import 'package:flint/pages/explore_page.dart';
// import 'package:flint/screens/likes.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    List bottomItems = [
      pageIndex == 0
          ? "assets/images/explore_active_icon.svg"
          : "assets/images/explore_icon.svg",
      pageIndex == 1
          ? "assets/images/likes_active_icon.svg"
          : "assets/images/likes_icon.svg",
      pageIndex == 2
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bottomItems.length, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  icon: SvgPicture.asset(
                    bottomItems[index],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [ExplorePage(), const MatchPage(), const ProfilePage()],
    );
  }

  PreferredSizeWidget? getAppBar() {
    return AppBar(
      elevation: 0,
      title: Text("Flint", style: Theme.of(context).textTheme.headline4),
      centerTitle: true,
    );
  }
}
