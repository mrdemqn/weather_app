import 'package:flutter/material.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/errors/network_error.dart';
import 'package:weather_app/models/weather_element.dart';
import 'package:weather_app/ui/internet_connection_lost_form.dart';
import 'package:weather_app/ui/weather_list_item.dart';

import 'wait_list_form.dart';

class WeatherListForm extends StatelessWidget {

  WeatherBloc get weatherBloc => WeatherBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<WeatherElement>>(
      initialData: weatherBloc.weatherElements,
      stream: weatherBloc.weatherStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError && snapshot.connectionState != ConnectionState.waiting)
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backwardsCompatibility: false,
              elevation: 0,
              title: Text(
                '${weatherBloc.currentCity?.name}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            body: SafeArea(
              top: false,
              child: ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, i) {
                  return WeatherListItem(weatherElement: snapshot.data?[i]);
                }),
            ),
          );
        else if (snapshot.hasError && snapshot.error == NetworkError)
          return InternetConnectionLostForm();
        else
          return WaitListForm();
      }
    );
  }
}
