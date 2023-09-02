import 'package:flutter/material.dart';
import 'package:weather_app/Service/supabseApi.dart';
import 'package:weather_app/componets/search_appbar_component.dart';
import 'package:weather_app/componets/search_componet.dart';
import 'package:weather_app/componets/weather_card_component.dart';
import 'package:weather_app/model/weather_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController SearchEdintController = TextEditingController();
  bool isMorning = false;

  @override
  void dispose() {
    SearchEdintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBarComponent(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SearchComponet(),
            Expanded(
              child: FutureBuilder(
                future: getCities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('حدث خطأ: ${snapshot.error}'),
                    );
                  } else {
                    List<Weather> cities = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        Weather city = cities[index];

                        var value = city.current!.isDay;

                        return WeatherCardComponent(
                          isDay: value!,
                          cityName: city.location!.name!,
                          status: city.current!.condition!.text!,
                          temp: city.current!.tempC.toString(),
                          weather: cities[index],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
