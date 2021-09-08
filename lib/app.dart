import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shortly_project/app/bindings/app_bindings.dart';
import 'package:shortly_project/app/routes/pages.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Given app designs are created with width: 375, height: 812
      designSize: Size(375, 812),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Shortly App",
        getPages: pages,
        color: Colors.white,
        initialBinding: AppBindings(),
      ),
    );
  }
}