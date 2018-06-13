import 'dart:async';

import 'package:licenta/database/database_helper.dart';
import 'package:licenta/exception/my_exception.dart';
import 'package:licenta/model/news.dart';

class SavedNewsRepository{
  DatabaseHelper databaseHelper = new DatabaseHelper();

  Future<List<News>> getNews() async {
    var newsList = await databaseHelper.getSavedNews();
    return newsList;
  }

  Future<int> deleteNews(News savedNews) async {
    var response;
    try {
      response =  await databaseHelper.deleteSavedNews(savedNews);
    } catch (e){
      throw new MyException('News does not exist');
    }

    return response;
  }
}