import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dualdoc/view/NewsPage.dart';
import 'package:dualdoc/view/ViewNews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:sizer/sizer.dart';

import '../contoller/NewsController.dart';

class HomeScreen extends StatelessWidget {
  NewsController newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
      body: Obx((() {
        return IndexedStack(
          index: newsController.tabIndex.value,
          children: [
            NewsBuilder(),
            Container(),
          ],
        );
      })),
    );
  }
}
