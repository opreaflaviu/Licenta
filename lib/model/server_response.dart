import 'dart:core';

import 'package:licenta/utils/constants.dart';

class ServerResponse {
  final String _responseType;
  final String _responseMessage;

  const ServerResponse(this._responseType, this._responseMessage);

  ServerResponse.fromMap(Map data):
    this._responseType = data[Constants.serverResponse][Constants.serverType],
    this._responseMessage = data[Constants.serverResponse][Constants.serverMessage];



  String get responseType => this._responseType;

  String get responseMessage => this._responseMessage;

  @override
  String toString() => _responseType + ": " + _responseMessage;
}