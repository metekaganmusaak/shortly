import 'package:get/get.dart';
import 'package:shortly_project/app/ui/pages/home/home_controller.dart';

class HomeControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}