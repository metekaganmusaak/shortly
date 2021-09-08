import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shortly_project/app/data/models/url_model.dart';
import 'package:shortly_project/app/data/provider/boxes.dart';
import 'package:shortly_project/app/ui/global_widgets/custom_text_form_field.dart';
import 'package:shortly_project/app/ui/pages/home/home_controller.dart';

class LinkHistoryView extends GetView<HomeController> {
  LinkHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFF1F7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
              child: Text(
                "Your Link History",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21.sp),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Obx(
              () {
                if (controller.isLoading.value)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else
                  return ValueListenableBuilder<Box<UrlModel>>(
                    valueListenable: Boxes.getURLS().listenable(),
                    builder: (context, box, _) {
                      final urls = box.values.toList().cast<UrlModel>();
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 14.h,
                          );
                        },
                        itemCount: urls.length,
                        itemBuilder: (context, index) {
                          return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 28.w, vertical: 0),
                                child: Container(
                                  height: 170.h,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 14.h,
                                            right: 14.w,
                                            bottom: 7.h,
                                            left: 14.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              urls[index].longURL,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Colors.black),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .deleteURL(urls[index]);
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/del.svg")),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 14.h,
                                            right: 14.w,
                                            bottom: 7.h,
                                            left: 14.w),
                                        child: Text(
                                          urls[index].shortURL,
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.cyan),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 14.h,
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                    text: urls[index].shortURL))
                                                .whenComplete(() => Get.snackbar(
                                                    "Success",
                                                    "Link copied successfully: ${urls[index].shortURL}", backgroundColor: Colors.green, colorText: Colors.white, icon: Icon(Icons.check, color: Colors.white,)));
                                          },
                                          child: Text("COPY"),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.cyan,
                                            fixedSize: Size.fromWidth(250.w),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                        },
                      );
                    },
                  );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: 375.w,
              height: 202.h,
              color: Color(0xff3F3558),
              child: Stack(
                children: [
                  Positioned(
                      right: 0.w,
                      top: 0.h,
                      child: SvgPicture.asset("assets/shape.svg")),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 47.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => CustomTextFormField(
                            textEditingController:
                                controller.urlTextController.value,
                            hintText: controller.shortUrlMessage.value,
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if(controller.urlTextController.value.text.isEmpty)
                            {
                              controller.color.value = Colors.red;
                              controller.urlTextController.value.text ="";
                              controller.shortUrlMessage.value = "This field can not be empty";
                              
                            }
                            else if(!controller.urlTextController.value.text.isURL){
                              controller.color.value = Colors.red;
                              controller.urlTextController.value.text ="";
                              controller.shortUrlMessage.value = "This is not a valid URL";
                              
                            }
                            else{
                              controller.handleButton(); 
                            }
                          },
                          child: Text(
                            "SHORTEN IT!",
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff2BD0D0),
                            fixedSize: Size.copy(Size(375.w, 55.h)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
