import 'package:flutter/material.dart';
import 'package:weather_app/Screens/search_screen.dart';
import 'package:weather_app/Service/supabseApi.dart';
import 'package:weather_app/componets/withear_status_component.dart';

class ViewDetailsStackComponent extends StatelessWidget {
  ViewDetailsStackComponent({
    super.key,
    required this.cityName,
    required this.status,
    required this.temp,
    required this.isDay,
    required this.localtime,
    this.iconUrl =
        "https://cdn.discordapp.com/attachments/1143925062072799385/1146719295255101530/sunny3x.png",
  });

  final String cityName;
  final String status;
  final String temp;
  final int isDay;
  final String localtime;
  String iconUrl;

  fun() {
    if (isDay == 1 && status == "Clear") {
      iconUrl =
          'https://cdn.discordapp.com/attachments/1143925062072799385/1146719295255101530/sunny3x.png';
    } else if (isDay == 1 && status == "Partly cloudy") {
      iconUrl =
          'https://cdn.discordapp.com/attachments/1143925062072799385/1146719757068927027/mostlysunny3x.png';
    } else if (isDay != 1 && status == "Clear") {
      iconUrl =
          'https://cdn.discordapp.com/attachments/1143925062072799385/1146720229922181170/nt_mostlycloudy3x.png';
    } else if (isDay != 1 && status == "Partly cloudy") {
      iconUrl =
          'https://cdn.discordapp.com/attachments/1143925062072799385/1146719910089740370/nt_tstorms3x.png';
    }

    return iconUrl;
  }

  @override
  Widget build(BuildContext context) {
    fun();
    return SizedBox(
      height: 500,
      width: 400,
      child: Stack(
        children: [
          Positioned(
            top: 70,
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 270,
            child: Row(
              children: [
                Text(
                  "Add City",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    addCity(cityName ?? "no city to add");
                    Navigator.pop(context);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => SearchScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 150,
            left: 80,
            child: SizedBox(
                height: 120,
                width: 320,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "$cityName",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        const Icon(
                          Icons.room,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "$temp°",
                          style: TextStyle(fontSize: 75, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 42),
                          child: Text(
                            "$status",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
          Positioned(
            top: 200,
            left: 80,
            child: Image.network(
              iconUrl,
              height: 250,
              width: 250,
            ),
          ),
          Positioned(
              top: 410,
              left: 130,
              child: Text(
                "$localtime",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              )),
        ],
      ),
    );
  }
}
