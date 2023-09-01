import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

Future<Weather> getWeatherData(String place) async {
  try {
    final uri = Uri.parse(
      "http://api.weatherapi.com/v1/current.json?key=7788ba5739b1435f9a171734233108&q=" +
          place,
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("can not get weather");
    }
  } catch (e) {
    rethrow;
  }
}
