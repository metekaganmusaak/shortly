import 'package:hive/hive.dart';
import 'package:shortly_project/app/data/models/url_model.dart';

class Boxes{
  static Box<UrlModel> getURLS() => Hive.box<UrlModel>('urls');
}