import 'package:flutter/material.dart';
import 'weather_tile.dart';

class Main_Widget extends StatelessWidget {
  final  location;
  final  temp;
  final  tempMin;
  final  tempMax;
  final  weather;
  final  humidity;
  final  windSpeed;
Main_Widget({
  required this.location,
  required this.temp,
  required this.tempMin,
  required this.tempMax,
  required this.weather,
  required this.humidity,
  required this.windSpeed,
});
  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[
        Container(
          height: MediaQuery.of(context).size.height/2,
          width:MediaQuery.of(context).size.width,
          color:const Color(0xfff1f1f1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              Text(location.toString(),
                style:const TextStyle(
                    fontSize:30.0,
                    fontWeight: FontWeight.w900
                ),
              ),
              Padding(
                padding:EdgeInsets.only(top:10.0,bottom:10.0),
                child:Text('${temp.toInt().toString()}°',
                    style:TextStyle(
                        color:Colors.purple,
                        fontSize:40.0,
                        fontWeight:FontWeight.w900
                    )
                ),
              ),
              Text(
                  "High of ${tempMax.toInt().toString()}°, low of ${tempMin.toInt().toString()}°",
                  style:TextStyle(
                    color:Color(0xff9e9e9e),
                    fontSize:14.0,
                    fontWeight: FontWeight.w600,
                  )
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                WeatherTile(icon: Icons.thermostat_outlined, title:'Temperature' , subtitle:'${temp.toInt().toString()}°'),
                WeatherTile(icon: Icons.filter_drama_outlined, title:'Weather' , subtitle:weather.toString()),
                WeatherTile(icon: Icons.wb_sunny, title:'Humidity' , subtitle:'${humidity.toString()}%'),
                WeatherTile(icon: Icons.waves_outlined, title:'wind speed' , subtitle:'${windSpeed.toString()} MPH'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
