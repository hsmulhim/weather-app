import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Service/weather_service.dart';
import 'package:weather_app/api_bloc/api_bloc.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  Weather weather = Weather();
  TextEditingController city = TextEditingController();

  Future<Weather> getWeather(String cityName) async {
    Weather weather = await getWeatherData(cityName);
    return weather;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: city,
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
