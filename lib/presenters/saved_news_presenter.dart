import 'package:licenta/model/news.dart';
import 'package:licenta/repository/saved_news_repository.dart';
import 'package:licenta/views/saved_news_body_view.dart';

class SavedNewsPresenter {

  SavedNewsRepository _savedNewsRepository;
  SavedNewsBodyView _savedNewsBodyView;

  SavedNewsPresenter(this._savedNewsBodyView){
    _savedNewsRepository = new SavedNewsRepository();
  }

  void getSavedNews() {
    _savedNewsRepository.getNews()
        .then((newsList) => _savedNewsBodyView.onLoadSavedNewsComplete(newsList))
        .catchError((error) => print("Error: ========== $error")//_savedNewsBodyView.onLoadSavedNewsError()
         );
  }

  void deleteSavedNews(News savedNews) {
    _savedNewsRepository.deleteNews(savedNews)
        .then((value) => _savedNewsBodyView.onDeletedSavedNewsComplete())
        .catchError((error) => print("Error: ========== $error")//_savedNewsBodyView.onDeletedSavedNewsError()
        );
  }


}