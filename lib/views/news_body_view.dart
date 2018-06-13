import 'package:licenta/model/news.dart';

abstract class NewsBodyView {

  void onLoadNewsComplete(List<News> news);
  void onLoadNewsError();

  void onAddedSavedNewsComplete();
  void onAddedSavedNewsError();
}