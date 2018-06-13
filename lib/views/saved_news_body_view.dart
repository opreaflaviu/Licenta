import 'package:licenta/model/news.dart';

abstract class SavedNewsBodyView {

  void onLoadSavedNewsComplete(List<News> savedNewsList);
  void onLoadSavedNewsError();

  void onDeletedSavedNewsComplete();
  void onDeletedSavedNewsError();
}