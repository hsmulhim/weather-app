import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

import '../Screens/view_page.dart';
import '../Service/weather_service.dart';

class SearchComponet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController city = TextEditingController();

    Future<List<String>> getCitySuggestions(String query) async {
      final suggestions = <String>[];

      final suggestionUri = Uri.parse(
        "http://api.weatherapi.com/v1/search.json?key=7788ba5739b1435f9a171734233108&q=" +
            query,
      );

      try {
        final response = await http.get(suggestionUri);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as List<dynamic>;
          suggestions.addAll(data.map((item) => item['name'].toString()));
        }
      } catch (e) {
        print('Error fetching city suggestions: $e');
      }
      return suggestions;
    }

    return Column(
      children: [
        TypeAheadField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: city,
            decoration: InputDecoration(
              hintText: 'Enter City',
              suffixIcon: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () async {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          suggestionsCallback: (pattern) async {
            return await getCitySuggestions(pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) async {
            final Weather weather = await getWeatherData(suggestion);
            print('Selected suggestion: ${suggestion.runtimeType}');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewPage(
                  weather: weather,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
