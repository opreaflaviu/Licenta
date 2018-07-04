import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:licenta/database/database_helper.dart';
import 'package:licenta/exception/my_exception.dart';
import 'package:licenta/model/news.dart';
import 'package:licenta/utils/constants.dart';
import 'package:webfeed/webfeed.dart';

class NewsRepository {
  static var _newsList = new List<News>();
  static DatabaseHelper _databaseHelper = new DatabaseHelper();

  Future<List<News>> getNews() async {
    if (_newsList.isEmpty) {
      var client = new http.Client();
      await client.get(Constants.newsURL).then((response) {
        var channel = new RssFeed.parse(response.body);
        _newsList = (channel.items.map((element) => (new News(
            element.link, element.title)))).toList();
        client.close();
      });
    }
    return _newsList;
  }

  Future<int> insertNews(News news) async {
    var response;
    try {
      response =  await _databaseHelper.insertNews(news);
    } catch (e){
      throw new MyException('News is already added');
    }

    return response;
  }
}