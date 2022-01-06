import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flint/data/explore_json.dart';
import 'package:flint/data/icons.dart';
import 'package:flint/theme/colors.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  // late CardController controller;

  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange"
  ];
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  List itemsTemp = [];
  int itemLength = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      itemsTemp = exploreJson;
      itemLength = exploreJson.length;
    });
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: const Duration(milliseconds: 500),
            ));
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
      bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody() {
    return Transform.scale(
      scale: 1.05,
      child: SizedBox(
        child: Expanded(
          child: SwipeCards(
            matchEngine: _matchEngine,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                shadowColor: Colors.black.withOpacity(0.5),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Image(
                        height: double.infinity,
                        image: AssetImage("assets/images/girls/img_16.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.9),
                              ],
                              stops: const [
                                0.6,
                                1.0
                              ])),
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _names[index],
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.merge(const TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          const Text("info",
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                    // SizedBox.expand(
                    //   child: Material(
                    //     color: Colors.transparent,
                    //     child: InkWell(
                    //       onTap: () =>
                    //           Navigator.pushNamed(context, '/movie_detail'),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              );
            },
            onStackFinished: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Stack Finished"),
                duration: Duration(milliseconds: 500),
              ));
            },
          ),
        ),
      ),
    );
  }

  Widget getBottomSheet() {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(itemIcons.length, (index) {
          return Ink(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                // changes position of shadow
              ),
            ]),
            width: itemIcons[index]['size'],
            height: itemIcons[index]['size'],
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                switch (index) {
                  case 0:
                    _matchEngine.currentItem?.nope();
                    break;
                  case 1:
                    _matchEngine.currentItem?.like();
                    break;
                  default:
                }
                print("pencet");
              },
              child: Center(
                child: SvgPicture.asset(
                  itemIcons[index]['icon'],
                  width: itemIcons[index]['icon_size'],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class Content {
  final String text;
  final Color color;

  Content({this.text = "", this.color = Colors.white});
}
