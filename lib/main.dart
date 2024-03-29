import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Widgets/main_widget.dart';

Future<WeatherInfo> fetchWeather()async{
  final zipCode = "560103";
  final apiKey = "41b15de76bc0a4dba93fb630654cec30";
  final requestUrl = "https://api.openweathermap.org/data/2.5/weather?zip=${zipCode},in&units=imperial&appid=${apiKey}";

  final response= await http.get(Uri.parse(requestUrl));
  if(response.statusCode==200){
    return WeatherInfo.fromJson(jsonDecode(response.body),);
  }else{
    throw Exception("Error loading request URL info");
  }
}

class WeatherInfo{
 final  location;
 final  temp;
 final tempMin;
 final tempMax;
 final weather;
 final humidity;
 final windSpeed;
 WeatherInfo({
   required this.location,
   required this.temp,
   required this.tempMin,
   required this.tempMax,
   required this.weather,
   required this.humidity,
   required this.windSpeed,
 });
 factory WeatherInfo.fromJson(Map<String, dynamic> json){
  return WeatherInfo(
      location: json['name'],
      temp:json['main']['temp'],
      tempMin:json['main']['temp_min'],
      tempMax:json['main']['temp_max'],
      weather:json['weather'][0]['description'],
      humidity:json['main']['humidity'],
      windSpeed:json['wind']['speed']
  );
 }

}

void main() => runApp(
 MaterialApp(
   title: "Tenki",
   home:MyApp(),
   debugShowCheckedModeBanner: false,
 )
);
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}
 @override
  _MyAppState createState() => _MyAppState();


class _MyAppState extends State<MyApp> {

  late Future<WeatherInfo> futureWeather;
  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<WeatherInfo>(
        future:futureWeather,
        builder:(context,snapshot){
          if(snapshot.hasData){
            return Main_Widget
              (
              location: snapshot.data!.location,
                temp: snapshot.data!.temp,
                tempMin: snapshot.data!.tempMin,
                tempMax: snapshot.data!.tempMax,
                weather: snapshot.data!.weather,
                humidity: snapshot.data!.humidity,
                windSpeed: snapshot.data!.windSpeed,
            );

          }else if(snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const CircularProgressIndicator();
          }
      )
    );
  }
}
