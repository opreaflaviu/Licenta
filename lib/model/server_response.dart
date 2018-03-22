import 'dart:core';

class ServerResponse {
  String _responseType;
  String _responseMessage;

  ServerResponse(this._responseType, this._responseMessage);

  ServerResponse.fromJson(Map data){
    this._responseType =data["response"]["type"];
    this._responseMessage =data["response"]["message"];
  }

  String get responseType => this._responseType;
  set responseType(String responseType) {
    this._responseType = responseType;
  } 

  String get responseMessage => this._responseMessage;
  set responseMessage(String responeMessage) {
    this._responseMessage =responeMessage;
  }

  @override
  String toString() => _responseType + ": " + _responseMessage;
}