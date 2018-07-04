import 'dart:async';

import 'package:licenta/database/database_helper.dart';
import 'package:licenta/exception/my_exception.dart';
import 'package:licenta/model/news.dart';

class SavedNewsRepository{
  static DatabaseHelper _databaseHelper = new DatabaseHelper();

  Future<List<News>> getNews() async {
    var newsList = await _databaseHelper.getSavedNews();
    return newsList;
  }

  Future<int> deleteNews(News savedNews) async {
    var response;
    try {
      response =  await _databaseHelper.deleteSavedNews(savedNews);
    } catch (e){
      throw new MyException('News does not exist');
    }

    return response;
  }
}