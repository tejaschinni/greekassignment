import 'dart:convert';

import 'package:http/http.dart' as http;

class APICall {
  String url = "https://hoblist.com/api/movieList";
  getAPIData(String lang) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: {"category": "movies", "language": lang, "genre": "all"});
      print(response.statusCode);
      Map result = json.decode(response.body.toString());
      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
