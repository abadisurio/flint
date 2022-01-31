import 'dart:developer' as dev;
import 'dart:math';

import 'package:flint/bloc/movie_bloc.dart';
import 'package:flint/data/explore_json.dart';
import 'package:flint/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ExploreMovie extends StatefulWidget {
  const ExploreMovie({Key? key}) : super(key: key);

  @override
  _ExploreMovieState createState() => _ExploreMovieState();
}

class _ExploreMovieState extends State<ExploreMovie>
    with TickerProviderStateMixin {
  final MovieBloc movieBloc = MovieBloc();
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  List itemsTemp = [];
  int itemLength = 0;

  @override
  void initState() {
    super.initState();

    // onStart();

    setState(() {
      itemsTemp = exploreJson;
      itemLength = exploreJson.length;
    });
    for (int i = 0; i < itemLength; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(
              movieId: i,
              title: itemsTemp[i]['name'],
              imageURI: itemsTemp[i]['img'],
              genres: itemsTemp[i]['genre']),
          likeAction: () {
            final newMovie = Movie(
                id: 250000 + Random().nextInt(300000 - 250000),
                title: itemsTemp[i]['name'],
                posterURL: itemsTemp[i]['img'],
                genre: itemsTemp[i]['genre'].join(' | '),
                level: 1);
            dev.log("suka");
            if (newMovie.title.isNotEmpty) {
              dev.log("suka2");
              movieBloc.addMovie(newMovie);
            }
            // log("suka");
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Liked"),
              duration: Duration(milliseconds: 500),
            ));
          },
          // likeAction: () {
          //   log("Like");
          // },
          nopeAction: () {
            dev.log("Nope");
          },
          superlikeAction: () {
            dev.log("Superlike");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.06,
      origin: const Offset(0, -120),
      child: SizedBox(
        child: SwipeCards(
          matchEngine: _matchEngine,
          itemBuilder: (BuildContext context, int index) {
            String title = _swipeItems[index].content.title;
            String imageURI = _swipeItems[index].content.imageURI;
            List<String> genres = _swipeItems[index].content.genres;
            String genresConcat = genres.join(' | ');
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
                  SizedBox(
                    width: double.infinity,
                    child: Image(
                      height: double.infinity,
                      image: AssetImage(imageURI),
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
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.merge(const TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        // Text(genres,
                        Text(genresConcat,
                            // Text(genres.map(item => item),
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 70,
                        ),
                      ],
                    ),
                  ),
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
    );
  }
}

class Content {
  final int movieId;
  final String title;
  final String imageURI;
  final List<String> genres;

  Content(
      {this.movieId = 0,
      this.title = "",
      this.imageURI = "",
      this.genres = const []});
}
