import 'dart:developer' as dev;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flint/bloc/movie_bloc.dart';
import 'package:flint/data/icons.dart';
import 'package:flint/screens/explore.dart';
import 'package:flint/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ExploreMovie extends StatefulWidget {
  final MovieWithDetail movieWithDetail;
  const ExploreMovie({Key? key, required this.movieWithDetail})
      : super(key: key);
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

    final movieWithDetail = widget.movieWithDetail;
    final data = movieWithDetail.data;
    final movies = data.movies;

    setState(() {
      itemsTemp = movies;
      itemLength = movies.length;
    });
    // dev.log("movies " + movies.toString());
    for (int i = 0; i < itemLength; i++) {
      // dev.log(movies[i].movieDetail.title.toString());
      _swipeItems.add(SwipeItem(
          content: movies[i],
          likeAction: () {
            dev.log("suka");
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Liked"),
              duration: Duration(milliseconds: 500),
            ));
          },
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
    // dev.log("movieWithDetail " + widget.movieWithDetail.toString());
    return Scaffold(
      body: getBody(),
      bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody() {
    return Transform.scale(
      scale: 1.06,
      origin: const Offset(0, -120),
      child: SizedBox(
        child: SwipeCards(
          matchEngine: _matchEngine,
          itemBuilder: (BuildContext context, int index) {
            final movie = _swipeItems[index].content;
            final MovieDetail movieDetail = movie.movieDetail;
            String title = movieDetail.title;
            String imageURI = movieDetail.posterPath;
            String genres = movie.genres.toString().split("|").join(" | ");
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
                    child: CachedNetworkImage(
                      height: double.infinity,
                      imageUrl: imageURI,
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
                        Text(genres,
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
