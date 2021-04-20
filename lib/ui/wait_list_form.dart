import 'package:flutter/material.dart';

class WaitListForm extends StatefulWidget {
  @override
  _WaitListFormState createState() => _WaitListFormState();
}

class _WaitListFormState extends State<WaitListForm> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  final ColorTween _tween = ColorTween(begin: Colors.grey[350], end: Colors.grey);

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = _tween.animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));
    _controller.repeat(reverse: true);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backwardsCompatibility: false,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          tweenWidget(),
          tweenWidget(),
          tweenWidget(),
          tweenWidget(),
          tweenWidget(),
          tweenWidget(),
          tweenWidget(),
        ],
      ),
    );
  }

  Widget tweenWidget() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => tile());
  }

  Widget tile() {
    return Center(
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: _animation.value,
              borderRadius: BorderRadius.circular(20)
          ),
        ),
        title: Container(
          height: 10,
          margin: const EdgeInsets.only(right: 100),
          decoration: BoxDecoration(
              color: _animation.value,
              borderRadius: BorderRadius.circular(20)
          ),
        ),
        subtitle: Container(
          height: 10,
          margin: const EdgeInsets.only(right: 50),
          decoration: BoxDecoration(
              color: _animation.value,
              borderRadius: BorderRadius.circular(20)
          ),
        ),
        trailing: Container(
          height: 20,
          width: 50,
          decoration: BoxDecoration(
              color: _animation.value,
              borderRadius: BorderRadius.circular(20)
          ),
        ),
      ),
    );
  }
}
