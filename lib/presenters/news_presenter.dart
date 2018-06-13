import 'package:licenta/model/news.dart';
import 'package:licenta/repository/news_repository.dart';
import 'package:licenta/views/news_body_view.dart';

class NewsPresenter {
  NewsRepository _newsRepository;
  NewsBodyView _newsBodyView;

  NewsPresenter(this._newsBodyView) {
    _newsRepository = new NewsRepository();
  }

  void getNews() {
    _newsRepository.getNews()
        .then((newsList) => _newsBodyView.onLoadNewsComplete(newsList))
        .catchError((error) => print("Error: ========== $error")//_newsBodyView.onLoadNewsError()
    );
  }

  void saveNews(News news){
    _newsRepository.insertNews(news)
        .then((value) => _newsBodyView.onAddedSavedNewsComplete())
        .catchError((error) => print("Error: ========== $error"));
  }
}
