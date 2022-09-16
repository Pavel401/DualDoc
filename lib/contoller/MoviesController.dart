import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/MovieModel.dart';
import 'package:http/http.dart' as http;

class MoviesController extends GetxController {
  List<Movie> moviedata = <Movie>[];

  // String baseApi =
  //"https://api.themoviedb.org/3/movie/popular?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_original_language=";
  ScrollController scrollController = ScrollController();
  RxBool notFound = false.obs;
  RxBool isLoading = false.obs;

  RxInt pageNum = 1.obs;
  dynamic isSwitched = false.obs;
  dynamic isPageLoading = false.obs;
  RxInt pageSize = 10.obs;

  getDataFromApi(url) async {
    // update();
    http.Response res = await http.get(Uri.parse(url));
    //print(res.body);
    if (res.statusCode == 200) {
      MovieList movieList = MovieList.fromJson(jsonDecode(res.body));

      // print(movieList.movies![1].posterPath);
      if (movieList.movies.length == 0 && movieList.totalMovies == 0) {
        notFound.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        //print(movieList.movies);
        update();
      } else if (movieList.movies!.length != 0) {
        moviedata = movieList.movies;
        //print(moviedata);
      } else {
        notFound.value = true;
        update();
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    var baseApi =
        "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&primary_release_date.gte=2020-01-01&primary_release_year=2022";

    getDataFromApi(baseApi);
    super.onInit();
  }
}
