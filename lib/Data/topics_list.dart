import 'package:food_order_app/Models/topic.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../main.dart';

class TopicsList {
  TopicsList();

  Future<List<Topic>> fetchTopics() async {
    HttpOverrides.global = MyHttpOverrides();
    final url = Uri.parse('https://localhost:5001/Topic/');
    final response = await http.get(url);
    var topics = (json.decode(response.body)['data'] as List)
        .map((data) => Topic.fromJson(data))
        .toList();

    return topics;
    //testing new git repo
  }
}
