import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  String url;
  NetworkHelper({required this.url});

  Future<dynamic> fetchData() async {
    var uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
