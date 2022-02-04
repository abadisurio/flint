// import 'dart:developer';

import 'package:flint/bloc/movie_bloc.dart';
import 'package:flint/data/likes_json.dart';
import 'package:flint/model/movie.dart';
import 'package:flutter/material.dart';

class LikesPage extends StatelessWidget {
  LikesPage({Key? key}) : super(key: key);

  final MovieBloc movieBloc = MovieBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getMoviesWidget(),
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

  Widget getMoviesWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: movieBloc.movies,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        return getMovieCardWidget(snapshot);
      },
    );
  }

  Widget getMovieCardWidget(AsyncSnapshot<List<Movie>> snapshot) {
    // log("snpashottt" + snapshot.hasData.toString());
    if (snapshot.hasData) {
      final data = snapshot.data!;
      return data.isNotEmpty
          ? GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 0.5625),
              itemBuilder: (context, index) {
                Movie movie = data[index];
                String title = movie.title;
                String genre = "";
                String posterURL = "";
                // String genre = movie.genre;
                // String posterURL = movie.posterURL;
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
                            image: AssetImage(posterURL),
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
                              // Text("ini nama",
                              Text(title,
                                  style: const TextStyle(color: Colors.white)),
                              Text(genre,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white)),
                            ],
                          ),
                        ),
                        SizedBox.expand(
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  movieBloc.deleteMovieById(0);
                                },
                              )),
                        )
                      ],
                    ),
                  ),
                );
              })
          // count(
          //   childAspectRatio: 0.5625,
          //   crossAxisCount: 2,
          //   children: List.generate(data.length, (index) {
          //     log("snpashottt" + data[index].genre);
          //     return SizedBox(
          //       height: 500,
          //       child: Card(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(15.0),
          //         ),
          //         elevation: 5,
          //         shadowColor: Colors.black.withOpacity(0.5),
          //         semanticContainer: true,
          //         clipBehavior: Clip.antiAliasWithSaveLayer,
          //         child: Stack(
          //           children: [
          //             SizedBox(
          //               width: double.infinity,
          //               child: Image(
          //                 height: double.infinity,
          //                 image: AssetImage(likesJson[index]['img']),
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //             Container(
          //               decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   gradient: LinearGradient(
          //                       begin: FractionalOffset.topCenter,
          //                       end: FractionalOffset.bottomCenter,
          //                       colors: [
          //                         Colors.black.withOpacity(0.0),
          //                         Colors.black.withOpacity(0.9),
          //                       ],
          //                       stops: const [
          //                         0.6,
          //                         1.0
          //                       ])),
          //               height: double.infinity,
          //               width: double.infinity,
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.all(20.0),
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: const [
          //                   Text("info",
          //                       style: TextStyle(color: Colors.white)),
          //                 ],
          //               ),
          //             ),
          //             SizedBox.expand(
          //               child: Material(
          //                   color: Colors.transparent,
          //                   child: InkWell(
          //                     onTap: () {
          //                       movieBloc.deleteMovieById(todo.id);
          //                     },
          //                   )),
          //             )
          //           ],
          //         ),
          //       ),
          //     );
          //   }),
          // )
          : Center(
              //this is used whenever there 0 Todo
              //in the data base
              child: noTodoMessageWidget(),
            );
    } else {
      return loadingData();
    }
  }

  Widget loadingData() {
    //pull todos again
    movieBloc.getMovies();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(),
          Text("Loading...",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  Widget noTodoMessageWidget() {
    return const Text(
      "Start adding Todo...",
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
    );
  }
}
