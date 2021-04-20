import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/models/weather_element.dart';
import 'package:weather_app/ui/weather_details_form.dart';

class WeatherListItem extends StatelessWidget {
  final WeatherElement? weatherElement;

  const WeatherListItem({Key? key, this.weatherElement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      leading: Image.network(weatherElement!.weatherItem!.icon!,
      width: 50,),
      title: Text(
        '${weatherElement?.dateTime?.hour.twoDigits}:${weatherElement?.dateTime?.minute.twoDigits}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w300
        ),
      ),
      subtitle: Text(
        '${weatherElement?.weatherItem?.description?.capitalize()}',
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
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(
            builder: (context) => WeatherDetailsForm(weatherElement: weatherElement)));
      },
    );
  }
}
