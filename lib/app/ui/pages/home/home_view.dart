import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shortly_project/app/controllers/network_controller.dart';
import 'package:shortly_project/app/ui/global_widgets/custom_text_form_field.dart';
import 'package:shortly_project/app/ui/pages/home/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends GetView<HomeController> {
  // Initiliaze the network controller to the check internet connectivity
  final NetworkController _networkController = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFF1F7),
      body: Obx(() {
        // This will check the internet connection, if there is no internet, then it will pop up the
        // please turn on the internet connection screen
        if (_networkController.hasConnection.value == false) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.signal_wifi_statusbar_connected_no_internet_4,
                    size: 56),
                Text(
                  "No Internet Connection\nPlease Check Your Internet",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          // If there is an internet connection, then this state will work
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: (controller.statusBarHeight + 10).h,
                  left: 28.w,
                  right: 28.w,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/logo.svg"),
                      SvgPicture.asset("assets/illustration.svg"),
                      Text(
                        "Let's get started!",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Text(
                        "Paste your first link into\nthe field to shorten it",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0.h,
                left: 0.w,
                right: 0.w,
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
                                hintTextColor: controller.color.value,
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (controller
                                    .urlTextController.value.text.isEmpty) {
                                  controller.color.value = Colors.red;
                                  controller.urlTextController.value.text = "";
                                  controller.shortUrlMessage.value =
                                      "This field can not be empty";
                                } else if (!controller
                                    .urlTextController.value.text.isURL) {
                                  controller.color.value = Colors.red;
                                  controller.urlTextController.value.text = "";
                                  controller.shortUrlMessage.value =
                                      "This is not a valid URL";
                                } else {
                                  controller.handleButton();
                                  Get.toNamed("/link_history");
                                }
                              },
                              child: Text(
                                "SHORTEN IT!",
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold),
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
          );
        }
      }),
    );
  }
}
