import 'package:flutter/material.dart';
import 'package:weather_app/constants/spacings.dart';
import 'package:weather_app/extensions/screen_size.dart';

import '../Screens/view_page.dart';
import '../model/weather_model.dart';

class WeatherCardComponent extends StatelessWidget {
  const WeatherCardComponent({
    super.key,
    required this.cityName,
    required this.status,
    required this.temp,
    required this.imgUrl,
    this.bgMColor = Colors.yellow,
    this.bgNColor = Colors.blue,
    required this.isDay,
    required this.weather,
  });

  final Color? bgMColor;
  final Color? bgNColor;
  final String cityName;
  final String status;
  final String temp;
  final String imgUrl;
  final bool isDay;
  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewPage(
                  weather: weather,
                )),
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(8),
        height: context.getHeight() * 0.18,
        width: context.getWidth() - 50,
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[4],
          color: isDay ? bgMColor : bgNColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cityName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    kVSpace16,
                    SizedBox(
                      width: 180,
                      child: Text(
                        status,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                    kVSpace8,
                    Expanded(
                      child: Text(
                        "${temp}°",
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Image.network(
                imgUrl,
                height: context.getHeight() * 0.17,
                width: context.getWidth() * 0.4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
