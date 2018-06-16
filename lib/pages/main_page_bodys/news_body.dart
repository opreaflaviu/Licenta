import 'dart:io';
import 'package:flutter/material.dart';
import 'package:licenta/model/news.dart';
import 'package:licenta/presenters/news_presenter.dart';
import 'package:licenta/utils/colors_constant.dart';
import 'package:licenta/utils/native_components.dart';
import 'package:licenta/views/news_body_view.dart';

class NewsBody extends StatefulWidget {
  @override
  _NewsBodyState createState() => new _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> implements NewsBodyView {
  List<News> _newsList;
  bool _isFetching;
  NewsPresenter _newsPresenter;

  _NewsBodyState() {
    _newsPresenter = new NewsPresenter(this);
  }

  @override
  void initState() {
    _isFetching = true;
    _newsPresenter.getNews();
    super.initState();
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
                            Icons.add_box,
                            color: Colors.lightBlue ),
                        onPressed: (){_saveNews(news);},
                      ),
                      new FlatButton(
                          textColor: Colors.black87,
                          splashColor: Colors.white,
                          onPressed: (){_openBrowserApp(news.link);},
                          child: new Text(
                              news.title.length < 30
                                  ? news.title
                                  : news.title.substring(0, 30) + '...',
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
  
  void _saveNews(News news){
    _newsPresenter.saveNews(news);
  }

  @override
  void onLoadNewsComplete(List<News> news) {
    setState(() {
      _newsList = news;
      _isFetching = false;
    });
  }

  @override
  void onLoadNewsError() {
    // TODO: implement onLoadNewsError
  }

  @override
  void onAddedSavedNewsComplete() {
    // TODO: implement onAddedSavedNewsComplete
  }

  @override
  void onAddedSavedNewsError() {
    // TODO: implement onAddedSavedNewsError
  }

  void _openBrowserApp(String web){
    if (_checkPlatform()) {
      try {
        NativeComponents.openBrowserApp(web);
      } catch (e){
        print("Open browser $e");
      }
    }
  }

  bool _checkPlatform() {
    return Platform.isAndroid == true;
  }

}