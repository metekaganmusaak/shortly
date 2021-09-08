import 'package:get/get.dart';
import 'package:shortly_project/app/routes/routes.dart';
import 'package:shortly_project/app/ui/pages/home/home_view.dart';
import 'package:shortly_project/app/ui/pages/link_history/link_history_view.dart';

final List<GetPage> pages = [
  GetPage(name: HOME_PAGE_ROUTE, page: () => HomeView()),
  GetPage(name: LINK_HISTORY_PAGE_ROUTE, page: () => LinkHistoryView()),
];