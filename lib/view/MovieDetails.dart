// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MovieDetailsScreen extends StatelessWidget {
  int voteCount = 0;
  int id = 0;
  bool video = false;
  String voteAverage = "";
  String title = "";
  double? popularity;
  String posterPath = "";
  String originalLanguage = "";
  String originalTitle = "";
  List<int> genreIds = [];
  String backdropPath = "";
  bool adult = false;
  String overview = "";
  String releaseDate = "";
  MovieDetailsScreen(
      {super.key,
      required this.title,
      required this.backdropPath,
      required this.voteCount,
      required this.adult,
      required this.originalLanguage,
      required this.overview});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie Details"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: this
                    .backdropPath
                    .replaceAll("http://image.tmdb.org/t/p/w500", ""),
                child: Container(
                  height: 25.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(this.backdropPath)),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3.w, right: 3.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          this.title,
                          style: TextStyle(
                              //color: Col

                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Overview",
                          style: TextStyle(
                              //color: Col

                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      this.overview,
                      style: const TextStyle(
                        //color: Col
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                      ),
                      //fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          "Suitable For Kids : ",
                          style: TextStyle(
                              //color: Col

                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          this.adult == true ? "No" : "Yes",
                          style: TextStyle(
                              //color: Col

                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Votings : ",
                          style: TextStyle(
                              //color: Col

                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          this.voteCount.toString(),
                          style: TextStyle(
                              //color: Col

                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "OriginalLanguage : ",
                          style: TextStyle(
                              //color: Col

                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          this.originalLanguage,
                          style: TextStyle(
                              //color: Col

                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
