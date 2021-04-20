import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          statusBarColor: Colors.transparent
        ))
      ),
      home: MyHomePage(title: 'Weather'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backwardsCompatibility: false,
        elevation: 0,
        title: Text(widget.title ?? '',
        style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Weather Application',
            ),
          ],
        ),
      ),
    );
  }
}
