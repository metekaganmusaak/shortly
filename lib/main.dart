import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shortly_project/app.dart';
import 'package:shortly_project/app/data/models/url_model.dart';

void main() async {
  // We need to initiliaze WidgetFlutter before the runApp func
  WidgetsFlutterBinding.ensureInitialized();
  // Initiliazing Hive
  await Hive.initFlutter();
  // Initiliazing our model's adapter
  Hive.registerAdapter(UrlModelAdapter());
  // creating a new box named 'urls'
  await Hive.openBox<UrlModel>('urls');

  // Setting status bar's and icon's color
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(App());
}

