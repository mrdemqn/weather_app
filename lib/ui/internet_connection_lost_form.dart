import 'package:flutter/material.dart';

class InternetConnectionLostForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Пожалуйста, проверьте интернет соединение...',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
