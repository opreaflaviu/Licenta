import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:licenta/model/news.dart';
import 'package:licenta/presenters/saved_news_presenter.dart';
import 'package:licenta/utils/colors_constant.dart';
import 'package:licenta/views/saved_news_body_view.dart';

class SavedNewsBody extends StatefulWidget {
  @override
  _SavedNewsBodyState createState() => new _SavedNewsBodyState();
}

class _SavedNewsBodyState extends State<SavedNewsBody> implements SavedNewsBodyView {
  List<News> _newsList;
  bool _isFetching;
  SavedNewsPresenter _savedNewsPresenter;

  _SavedNewsBodyState() {
    _savedNewsPresenter = new SavedNewsPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isFetching = true;
    _loadSavedNews();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (_isFetching) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = new Container(
          padding: new EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: new ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _newsList == null ? 0 : _newsList.length,
            itemBuilder: (BuildContext context, int index) {
              News news = _newsList.elementAt(index);
              return new Card(
                color: ColorsConstants.backgroundColorBlue,
                elevation: 1.0,
                child: new Padding(
                  padding: new EdgeInsets.only(left: 0.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new IconButton(
                        splashColor: Colors.white,
                        icon: new Icon(
                            Icons.delete,
                            color: Colors.lightBlue ),
                        onPressed: (){_deleteSavedNews(news);},
                      ),
                      new FlatButton(
                          textColor: Colors.black87,
                          splashColor: Colors.white,
                          onPressed: (){print(news.title + " " + news.link);},
                          child: new Text(
                              news.title.length < 35
                                  ? news.title
                                  : news.title.substring(0, 35) + '...',
                              textAlign: TextAlign.center,
                              style: new TextStyle(fontSize: 16.0)))
                    ],
                  ),
                ),
              );
            },
          ));
    }
    return widget;
  }

  void _loadSavedNews(){
    _savedNewsPresenter.getSavedNews();
  }

  void _deleteSavedNews(News news){
    print("dasdsadasdsa ${news.link}    ${news.title}");
    _savedNewsPresenter.deleteSavedNews(news);
  }

  @override
  void onLoadSavedNewsComplete(List<News> savedNewsList) {
    setState((){
      _newsList = savedNewsList;
      _isFetching = false;
    });
  }

  @override
  void onLoadSavedNewsError() {
    // TODO: implement onLoadSavedNewsError
  }

  @override
  void onDeletedSavedNewsComplete() {
    print("delete complete");
    _loadSavedNews();
  }

  @override
  void onDeletedSavedNewsError() {
    // TODO: implement onDeletedSavedNewsError
  }

}