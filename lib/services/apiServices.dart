import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiServices {
  static const int timeOutDuration = 120;

  Future<dynamic> getData({required String api}) async {
    var uri = Uri.parse("https://jsonplaceholder.typicode.com$api");
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };


      var response = await http.get(uri, headers: headers).timeout(Duration(seconds: timeOutDuration));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get data: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('API request timed out');
    } on SocketException {
      throw Exception('No internet connection');
    }
  }
  }