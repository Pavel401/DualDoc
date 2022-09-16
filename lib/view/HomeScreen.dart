import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dualdoc/view/MoviesPage.dart';
import 'package:dualdoc/view/NewsPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';

import '../contoller/NewsController.dart';

class HomeScreen extends StatelessWidget {
  NewsController newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
        () => CustomNavigationBar(
          elevation: 5,
          //isFloating: true,
          iconSize: 30.0,

          //borderRadius: Radius.circular(12),
          // selectedColor: theme.neoncolor,
          strokeColor: Color(0x30040307),
          unSelectedColor: Colors.white,
          backgroundColor: HexColor("#3D4552"),
          items: [
            CustomNavigationBarItem(
              icon: const HeroIcon(HeroIcons.home),
            ),
            CustomNavigationBarItem(
              icon: const HeroIcon(HeroIcons.collection),
            ),
          ],
          currentIndex: newsController.tabIndex.value,
          onTap: newsController.changeTabIndex,
        ),
      ),
      body: Obx((() {
        return IndexedStack(
          index: newsController.tabIndex.value,
          children: [
            NewsBuilder(),
            MoviesPage(),
          ],
        );
      })),
    );
  }
}
