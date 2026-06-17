import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/views/CountriesApiScreen.dart';
import 'package:notes_app/views/HomeScreen.dart';

class Navigationservice extends GetxService {
  var currentPage = 0.obs;
  var previousPage = 0.obs;

  List<Widget> pages = [HomeScreen(), Countriesapiscreen()];

  void updateindex(int index) {
    previousPage.value = currentPage.value;
    currentPage.value = index;  
  }
}
