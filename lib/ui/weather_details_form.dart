import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/models/weather_element.dart';

class WeatherDetailsForm extends StatelessWidget {
  final WeatherElement? weatherElement;

  const WeatherDetailsForm({Key? key, this.weatherElement}) : super(key: key);

  WeatherBloc get weatherBloc => WeatherBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backwardsCompatibility: false,
        elevation: 0,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Icon(
            CupertinoIcons.back,
            size: 30,
            color: Colors.black,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          '${weatherElement?.dateTime?.weekday == DateTime.now().weekday ? 'Today' : 'Other day'}',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Image.network(weatherElement!.weatherItem!.icon!,
              width: 60,),
            SizedBox(height: 15),
            Text(
              '${weatherBloc.currentCity?.name}, ${weatherBloc.currentCity?.countryCode}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal
              ),
            ),
            SizedBox(height: 15),
            Text(
              '${weatherElement?.mainItem?.temperature?.round()}°C  |  ${weatherElement?.weatherItem?.main}',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
                fontWeight: FontWeight.normal
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.cloud_heavyrain,
                            size: 15,
                            color: Colors.amber,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${weatherElement?.mainItem?.humidity} %',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 130),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.wind,
                              size: 15,
                              color: Colors.amber,
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${weatherElement?.windItem?.windSpeed?.round()} km/h',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.drop,
                            size: 15,
                            color: Colors.amber,
                          ),
                          SizedBox(height: 5),
                          Text(
                            weatherElement?.rainItem?.rainVolume != null
                                ? '${weatherElement?.rainItem?.rainVolume} mm'
                                : 'No found',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 130),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.compass,
                              size: 15,
                              color: Colors.amber,
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${weatherBloc.getWindDirection(weatherElement!.windItem!.windDirection!)}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.hammer,
                            size: 15,
                            color: Colors.amber,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${weatherElement?.mainItem?.groundLevel} hPa',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            SizedBox(height: 100),
            GestureDetector(
              child: Container(
                height: 70,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueAccent[700],
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              onTap: () async {
                await weatherBloc.shareWeatherText(
                    'Влажность - ${weatherElement?.mainItem?.humidity} %\n'
                    'Скорость ветра - ${weatherElement?.windItem?.windSpeed?.round()} km/h\n'
                    'Направление ветра - ${weatherBloc.getWindDirection(weatherElement!.windItem!.windDirection!)}'
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
