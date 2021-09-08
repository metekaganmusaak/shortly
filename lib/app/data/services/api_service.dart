import 'dart:async';

import 'package:shortly_project/app/data/models/url_shortener_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String?> getShortLink(String longUrl) async {
    try {
      // parse the link
      final uri = Uri.parse("https://api.shrtco.de/v2/shorten?url=$longUrl");
      // use http post to get a result
      final result = await http.post(uri);
      if (result.statusCode == 100) {
        return "Informational Responses";
      } else if (result.statusCode == 201) {
        // if status code is 201, that means our data fetched successfully.
        print("Succesfully Completed");
        // use the resultFromJson method which we have in our UrlShortenerModel class
        final response = resultFromJson(result.body);
        // we need a shortlink => send back the shorted link to our home controller
        return response.result.shortLink;
      } else if (result.statusCode == 300) {
        return "Redirects";
      } else if (result.statusCode == 400) {
        return "Client Errors";
      } else if (result.statusCode == 500) {
        return "Server Errors";
      } else {
        print("Hmm... Something went wrong");
        print(result.body);
        print(result.statusCode);
        return "???";
      }
    } catch (e) {
      Exception(e);
    }
  }
}
