import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weather_app/Service/weather_service.dart';
import 'package:weather_app/model/weather_model.dart';

subabaseConfing() async {
  await Supabase.initialize(
    url: "https://slugqdqfqhrsfhabfvzk.supabase.co/",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNsdWdxZHFmcWhyc2ZoYWJmdnprIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTM0NjgwNjMsImV4cCI6MjAwOTA0NDA2M30.44yAzF49T7JZiqjJtG4J5G2e1RjhDcyenHQ76aMLvj0",
  );
}

Future getCity() async {
  final List cityList =
      await Supabase.instance.client.from("city").select("city_name");
  return cityList;
}

Future<List<String>?> getCitiesNames() async {
  final supabase = Supabase.instance.client;
  final List citiesJson = await supabase.from('city').select();
  final List<String> cities = [];
  for (final city in citiesJson) {
    cities.add(city["city_name"]);
  }
  return cities;
}

Future<List<Weather>?> getCities() async {
  final List<String>? citiesName = await getCitiesNames();
  final List<Weather>? cities = [];
  for (final cityName in citiesName!) {
    cities!.add(await getWeatherData(cityName));
  }
  return cities;
}

Future addCity(String city_name) async {
  final List cityList = await Supabase.instance.client
      .from("city")
      .insert({"city_name": city_name});
  return cityList;
}


Future removeCity(String cityname) async {
  final cityList = await Supabase.instance.client
      .from("city")
      .delete()
      .match({'city_name': cityname});
  return cityList;
}
