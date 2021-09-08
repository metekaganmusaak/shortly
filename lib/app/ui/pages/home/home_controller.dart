import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortly_project/app/data/models/url_model.dart';
import 'package:shortly_project/app/data/provider/boxes.dart';

import 'package:shortly_project/app/data/services/api_service.dart';

class HomeController extends GetxController {
  final double statusBarHeight = Get.mediaQuery.padding.top;

  // text form fields text
  var urlTextController = TextEditingController().obs;
  // initiliaze the api service to fetch the datas from api
  final ApiService apiService = ApiService();

  // checking for status
  var isLoading = true.obs;

 // Default label text color
  var color = Colors.grey.shade400.obs;
  // Default label text
  var shortUrlMessage = "Shorten a link here ...".obs;

  // saving links to the hive db
  Future addURL(String longURL, String shortURL) async {
    final urls = UrlModel()
    ..longURL = longURL
    ..shortURL = shortURL;

    //urlModels.add(urls);
    final box = Boxes.getURLS();
    box.add(urls);
  }

  // deleting links from the hive db
  void deleteURL(UrlModel urlModel){
    final box = Boxes.getURLS();
    box.delete(urlModel.key);
  }


  // when pressed "SHORTEN IT!" button, this methods will work
  handleButton() async {
    try {
      // when state is loading => to show circular progress indicator while waiting for the response from the api
      isLoading(true);
      // keep the link which user wrote
      final String longURL = urlTextController.value.text;
      // then send this link to the api service to make it short, it will bring back the short one
      // and keep it to the short
      final String? shortURL = await apiService.getShortLink(longURL);
      // send long and short ones to the hive db to save them
      addURL(longURL, shortURL!);
      shortUrlMessage.value = "$shortUrlMessage";
    } finally {
      isLoading(false);
    }
  }
}
