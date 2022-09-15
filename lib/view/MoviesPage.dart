import 'package:cached_network_image/cached_network_image.dart';
import 'package:dualdoc/contoller/MoviesController.dart';
import 'package:dualdoc/contoller/NewsController.dart';
import 'package:dualdoc/view/MovieDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

class MoviesPage extends StatelessWidget {
  MoviesPage({super.key});
  MoviesController moviesController = Get.put(MoviesController());
  NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TBDB Trending Movies"),
        actions: [
          GetBuilder<NewsController>(
            builder: (controller) => Switch(
              value: controller.isSwitched == true ? true : false,
              onChanged: (value) => controller.changeTheme(value),
              activeTrackColor: Colors.yellow,
              activeColor: Colors.red,
            ),
            init: NewsController(),
          ),
        ],
      ),
      body: GetBuilder<MoviesController>(
        builder: (controller) {
          return controller.notFound.value
              ? Center(child: Text("Not Found", style: TextStyle(fontSize: 30)))
              : controller.moviedata.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        //print(controller.moviedata[1]);
                        return InkWell(
                          onTap: () {
                            Get.to(MovieDetailsScreen(
                                title: controller.moviedata[index].title,
                                backdropPath: "http://image.tmdb.org/t/p/w500" +
                                    controller.moviedata[index].backdropPath
                                        .toString(),
                                voteCount:
                                    controller.moviedata[index].voteCount,
                                adult: controller.moviedata[index].adult,
                                originalLanguage: controller
                                    .moviedata[index].originalLanguage,
                                overview:
                                    controller.moviedata[index].overview));
                          },
                          child: Hero(
                            tag: controller.moviedata[index].backdropPath,
                            child: Container(
                              color: Colors.transparent,
                              height: 22.h,
                              width: 90.w,
                              //color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  //color: HexColor("#1E1E1E"),
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          height: 15.h,
                                          width: 30.w,
                                          child: controller.moviedata[index]
                                                      .backdropPath
                                                      .toString() ==
                                                  "NULL"
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: Image(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "assets/loading.png"),
                                                  ))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    image:
                                                        "http://image.tmdb.org/t/p/w500" +
                                                            controller
                                                                .moviedata[
                                                                    index]
                                                                .backdropPath
                                                                .toString(),
                                                    placeholder:
                                                        "assets/loading.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          SizedBox(
                                            width: 50.w,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextScroll(
                                                    controller.moviedata[index]
                                                                .title ==
                                                            "NULL"
                                                        ? "N/A"
                                                        : controller
                                                            .moviedata[index]
                                                            .title,
                                                    velocity: Velocity(
                                                        pixelsPerSecond:
                                                            Offset(20, 0)),
                                                    pauseBetween: Duration(
                                                        milliseconds: 1000),
                                                    mode:
                                                        TextScrollMode.bouncing,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    textAlign: TextAlign.right,
                                                    selectable: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            controller.moviedata[index]
                                                        .releaseDate
                                                        .toString() ==
                                                    "null"
                                                ? "N/A"
                                                : "Released : " +
                                                    controller.moviedata[index]
                                                        .releaseDate
                                                        .toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: controller.moviedata.length,
                    );
        },
        init: MoviesController(),
      ),
    );
  }
}
