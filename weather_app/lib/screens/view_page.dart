import 'package:flutter/material.dart';
import 'package:weather_app/componets/view_details_component.dart';

import '../Service/supabseApi.dart';
import '../componets/withear_status_component.dart';
import '../model/weather_model.dart';

class ViewPage extends StatelessWidget {
  ViewPage({super.key, required this.weather});
  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: weather.current!.isDay == 1
          ? Color.fromARGB(255, 152, 224, 250)
          : Color.fromARGB(255, 20, 97, 159),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: weather.current!.isDay == 1
            ? Color.fromARGB(255, 152, 224, 250)
            : Color.fromARGB(255, 20, 97, 159),
        actions: [
          IconButton(
              onPressed: () {
                addCity(weather.location?.name ?? 'no city to add');
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SizedBox(
        height: 800,
        width: 600,
        child: Column(
          children: [
            ViewDetailsStackComponent(
                cityName: weather.location?.name ?? 'no name ',
                imgUrl:
                    'https://icon-library.com/images/sunny-weather-icon/sunny-weather-icon-13.jpg',
                isDay: weather.current?.isDay ?? 0,
                status: weather.current?.condition?.text ?? 'no con',
                temp: weather.current?.tempC?.toString() ?? 'no temp',
                localtime:
                    weather.location?.localtime?.toString() ?? 'no time'),
            WithearStatusComponent(
              humidity: weather.current?.humidity?.toString() ?? 'no humidity',
              cloud: weather.current?.cloud?.toString() ?? 'no cloud',
              windKph: weather.current?.windKph?.toString() ?? 'no windkph',
            )
          ],
        ),
      ),
    );
  }
}
