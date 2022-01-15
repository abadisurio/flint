import 'package:flint/data/likes_json.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key}) : super(key: key);
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return GridView.count(
      childAspectRatio: 0.5625,
      crossAxisCount: 2,
      children: List.generate(likesJson.length, (index) {
        return SizedBox(
          height: 500,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            shadowColor: Colors.black.withOpacity(0.5),
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    height: double.infinity,
                    image: AssetImage(likesJson[index]['img']),
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
                    children: const [
                      Text("info", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox.expand(
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                      )),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
