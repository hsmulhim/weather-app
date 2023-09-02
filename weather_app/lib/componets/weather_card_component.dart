import 'package:flutter/material.dart';
import 'package:weather_app/constants/spacings.dart';
import 'package:weather_app/extensions/screen_size.dart';

import '../Screens/view_page.dart';
import '../model/weather_model.dart';

class WeatherCardComponent extends StatelessWidget {
  WeatherCardComponent({
    super.key,
    required this.cityName,
    required this.status,
    required this.temp,
    this.imgUrl =
        "https://cdn.discordapp.com/attachments/1143925062072799385/1146719757068927027/mostlysunny3x.png",
    this.bgMColor = const Color.fromARGB(255, 152, 224, 250),
    this.bgNColor = const Color.fromARGB(255, 20, 97, 159),
    required this.isDay,
    required this.weather,
  });

  final Color? bgMColor;
  final Color? bgNColor;
  final String cityName;
  final String status;
  final String temp;
  String imgUrl;
  final int isDay;
  final Weather weather;
  fun() {
    if (isDay == 1 && status == "Clear") {
      imgUrl =
          'https://cdn.discordapp.com/attachments/1143925062072799385/1146719295255101530/sunny3x.png';
    } else if (isDay == 1 && status == "Partly cloudy") {
      imgUrl =
          'https://cdn.discordapp.com/attachments/1143925062072799385/1146719757068927027/mostlysunny3x.png';
    } else if (isDay != 1 && status == "Clear") {
      imgUrl =
          'https://cdn.discordapp.com/attachments/1143925062072799385/1146720229922181170/nt_mostlycloudy3x.png';
    } else if (isDay != 1 && status == "Partly cloudy") {
      imgUrl =
          'https://cdn.discordapp.com/attachments/1143925062072799385/1146719910089740370/nt_tstorms3x.png';
    }

    return imgUrl;
  }

  @override
  Widget build(BuildContext context) {
    fun();
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
          color: isDay == 1 ? bgMColor : bgNColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
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
              width: context.getWidth() * 0.3,
            ),
          ]),
        ),
      ),
    );
  }
}
