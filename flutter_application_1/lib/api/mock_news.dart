import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/news_model.dart';

Future<List<NewsModel>> readJsonData() async {
  final jsondata = await rootBundle.loadString('assets/json/data.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => NewsModel.fromJson(e)).toList();
}
