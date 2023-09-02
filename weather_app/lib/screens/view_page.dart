import 'package:flutter/material.dart';
import 'package:weather_app/componets/view_details_component.dart';

import '../Service/supabseApi.dart';
import '../componets/withear_status_component.dart';
import '../model/weather_model.dart';

class ViewPage extends StatelessWidget {
  ViewPage({super.key, required this.weather});

  final Weather weather;
  String imgUrl =
      "https://i.pinimg.com/originals/9e/79/26/9e79266ee52e0b55b6e191d45e856d13.gif";

  fun() {
    int isDay = weather.current?.isDay ?? 0;
    String status = weather.current?.condition!.text ?? 'Clear';

    if (isDay == 1 && status == "Clear") {
      imgUrl =
          'https://i.pinimg.com/originals/9e/79/26/9e79266ee52e0b55b6e191d45e856d13.gif';
    } else if (isDay == 1 && status == "Partly cloudy") {
      imgUrl = 'https://i.gifer.com/Lx0q.gif';
    } else if (isDay != 1 && status == "Clear") {
      imgUrl = 'https://media.tenor.com/uB8rQEtcJDYAAAAC/weather-time.gif';
    } else if (isDay != 1 && status == "Partly cloudy") {
      imgUrl = 'https://media.tenor.com/GUAQb8zhXJgAAAAC/rain-rainy-day.gif';
    }

    return imgUrl;
  }

  @override
  Widget build(BuildContext context) {
    fun();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              imgUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            ViewDetailsStackComponent(
                cityName: weather.location?.name ?? 'no name ',
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
