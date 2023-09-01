import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/api_bloc/api_bloc.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TypeAheadField<String>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: city,
                decoration: InputDecoration(labelText: 'Enter City'),
              ),
              suggestionsCallback: (pattern) async {
                return await getCitySuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                context.read<ApiBloc>().add(SearchCityEvent(suggestion));
              },
            ),
            ElevatedButton(
              onPressed: () async {
                context.read<ApiBloc>().add(SearchCityEvent(city.text));
              },
              child: Text("Get Weather"),
            ),
            BlocBuilder<ApiBloc, ApiState>(
              builder: (context, state) {
                if (state is SearchApiCityState) {
                  return ListTile(
                    leading: Text(
                      state.weather.location?.name ?? "test",
                    ),
                    title: Text(
                      state.weather.current?.tempC.toString() ?? "test",
                    ),
                  );
                } else if (state is GetCityLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is GetCityFaildState) {
                  return Text("error");
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
