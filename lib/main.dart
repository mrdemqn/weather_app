import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/ui/weather_list_form.dart';

import 'utils/network_connection/internet_status_check.dart';

ConnectionStatus get connectionStatus => ConnectionStatus();
void main() async {
  await connectionStatus.checkConnection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent),
        backgroundColor: Colors.white)
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  WeatherBloc get weatherBloc => WeatherBloc();

  @override
  void initState() {
    weatherBloc.getWeatherElements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WeatherListForm();
  }
}
