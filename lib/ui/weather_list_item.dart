import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/models/weather_element.dart';

class WeatherListItem extends StatelessWidget {
  final WeatherElement? weatherElement;

  const WeatherListItem({Key? key, this.weatherElement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      leading: Icon(
        CupertinoIcons.sun_max_fill,
        size: 50,
        color: Colors.amber,
      ),
      title: Text(
        '${weatherElement?.dateTime?.hour.twoDigits}:${weatherElement?.dateTime?.minute.twoDigits}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w300
        ),
      ),
      subtitle: Text(
        '${weatherElement?.weatherItem?.description}',
        style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w300
        ),
      ),
      trailing: Text(
        '${weatherElement?.mainItem?.temperature?.round()}°C',
        style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 26,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}
