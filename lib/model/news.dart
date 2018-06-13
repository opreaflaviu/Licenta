import 'package:licenta/utils/constants.dart';

class News {
  final String _title;
  final String _link;

  const News(this._link, this._title);

  String get link => _link;

  String get title => _title;

  Map<String, String> toMap(){
    var map = new Map<String, String>();
    map[Constants.newsTitle] = this._title;
    map[Constants.newsLink] = this._link;
    return map;
  }

  News.fromMap(Map map):
      this._title = map[Constants.newsTitle],
      this._link = map[Constants.newsLink];


  @override
  String toString() {
    return 'News{_title: $_title, _link: $_link}';
  }


}