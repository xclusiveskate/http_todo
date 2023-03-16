import 'dart:convert';

import 'package:http/http.dart' as http;
import 'model.dart';

List<Album> results = [];
var data = [];

class HttpCall {
  var endpoint = Uri.parse("https://jsonplaceholder.typicode.com/todos");

  getRequest() async {
    try {
      var response = await http.get(endpoint);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        // results = data.map((e) => Album.fromJson(e)).toList();
        // print(data);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }
}
