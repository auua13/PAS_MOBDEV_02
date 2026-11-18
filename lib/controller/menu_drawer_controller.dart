import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_gasal_02/menu/feat.dart';
import 'package:pas_gasal_02/menu/home.dart';
import 'package:pas_gasal_02/menu/profile.dart';

class MainMenuController extends GetxController{

  final RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
    List<Widget> pages = [
    KulinerPage(),
    FeatPage(),
    ProfilePage(),
  ];
}