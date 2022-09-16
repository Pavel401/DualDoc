import 'package:cached_network_image/cached_network_image.dart';
import 'package:dualdoc/view/ViewNews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../contoller/NewsController.dart';

class NewsBuilder extends StatelessWidget {
  NewsBuilder({
    Key? key,
  }) : super(key: key);
  NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("News"),
        actions: [
          IconButton(
            onPressed: () {
              newsController.country.value = '';
              newsController.category.value = '';
              newsController.findNews.value = '';
              newsController.cName.value = '';
              newsController.getNews(reload: true);
              newsController.update();
            },
            icon: Icon(Icons.refresh),
          ),
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
      body: GetBuilder<NewsController>(
        builder: (controller) {
          return controller.notFound.value
              ? Center(child: Text("Not Found", style: TextStyle(fontSize: 30)))
              : controller.news.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: GestureDetector(
                                  onTap: () => Get.to(ViewNews(
                                      newsUrl: controller.news[index].url)),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(children: [
                                          controller.news[index].urlToImage ==
                                                  null
                                              ? Container(
                                                  child: const Center(
                                                      child:
                                                          Text("No Image !")),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                    placeholder: (context,
                                                            url) =>
                                                        Container(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    imageUrl: controller
                                                            .news[index]
                                                            .urlToImage ??
                                                        '',
                                                  ),
                                                ),
                                          Positioned(
                                            bottom: 8,
                                            right: 8,
                                            child: Card(
                                              elevation: 0,
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.8),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                child: Text(
                                                    "${controller.news[index].source.name}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        SizedBox(height: 2.h),
                                        Text("${controller.news[index].title}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Published on: ${controller.news[index].publishedAt.replaceRange(10, 20, "")}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12)),
                                          ],
                                        ),
                                        const Divider(),
                                        Text(
                                            "Author: "
                                            "${controller.news[index].author}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12)),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            index == controller.news.length - 1 &&
                                    // ignore: unrelated_type_equality_checks
                                    controller.isLoading == true
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : const SizedBox(),
                          ],
                        );
                      },
                      itemCount: controller.news.length,
                    );
        },
        init: NewsController(),
      ),
    );
  }
}
