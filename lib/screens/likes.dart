import 'package:flint/data/likes_json.dart';
import 'package:flutter/material.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);
  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
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
        // return SizedBox(
        //   width: (size.width - 15) / 2,
        //   height: 250,
        //   child: Stack(
        //     children: [
        //       Container(
        //         width: (size.width - 15) / 2,
        //         height: 250,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             image: DecorationImage(
        //                 image: AssetImage((likesJson[index]['img'])),
        //                 fit: BoxFit.cover)),
        //       ),
        //       Container(
        //         width: (size.width - 15) / 2,
        //         height: 250,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             gradient: LinearGradient(
        //                 colors: [
        //                   black.withOpacity(0.25),
        //                   black.withOpacity(0),
        //                 ],
        //                 end: Alignment.topCenter,
        //                 begin: Alignment.bottomCenter)),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //             likesJson[index]['active']
        //                 ? Padding(
        //                     padding:
        //                         const EdgeInsets.only(left: 8, bottom: 8),
        //                     child: Row(
        //                       children: [
        //                         Container(
        //                           width: 8,
        //                           height: 8,
        //                           decoration: const BoxDecoration(
        //                               color: green,
        //                               shape: BoxShape.circle),
        //                         ),
        //                         const SizedBox(
        //                           width: 5,
        //                         ),
        //                         const Text(
        //                           "Recently Active",
        //                           style: TextStyle(
        //                             color: white,
        //                             fontSize: 14,
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   )
        //                 : Padding(
        //                     padding:
        //                         const EdgeInsets.only(left: 8, bottom: 8),
        //                     child: Row(
        //                       children: [
        //                         Container(
        //                           width: 8,
        //                           height: 8,
        //                           decoration: const BoxDecoration(
        //                               color: grey,
        //                               shape: BoxShape.circle),
        //                         ),
        //                         const SizedBox(
        //                           width: 5,
        //                         ),
        //                         const Text(
        //                           "Offline",
        //                           style: TextStyle(
        //                             color: white,
        //                             fontSize: 14,
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // );
      }),
    );
    // return ListView(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.only(top: 20),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           Text(
    //             likesJson.length.toString() + " Likes",
    //             style:
    //                 const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //           ),
    //           const Text(
    //             "Top Picks",
    //             style: TextStyle(
    //                 fontSize: 18, fontWeight: FontWeight.bold, color: grey),
    //           ),
    //         ],
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     const Divider(
    //       thickness: 0.8,
    //     ),
    //     Expanded(
    //       child: SizedBox(
    //         height: 600,
    //         child:
    //       ),
    //     )
    //   ],
    // );
  }
}
