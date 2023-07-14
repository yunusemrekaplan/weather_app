import 'dart:io';

import 'package:http/http.dart' as http;

class CityService {
  static Future getWeatherCity(String city) async {
    return await http.get(
      Uri.parse('https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city'),
      headers: {
        HttpHeaders.authorizationHeader: 'apiKey 0M89LfyFhBnX1dSqhsEYTj:2DVjMfBLe6trIxORBCp1hV', // api key
        HttpHeaders.contentTypeHeader: 'application/json' // tpye
      }
    );
  }
}