import 'package:hive/hive.dart';

part 'url_model.g.dart';

@HiveType(typeId: 0)
class UrlModel extends HiveObject{

  @HiveField(0)
  late String longURL;

  @HiveField(1)
  late String shortURL;


}
