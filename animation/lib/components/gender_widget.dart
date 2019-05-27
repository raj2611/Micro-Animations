import 'package:flutter/material.dart';

class GenderWidget extends StatefulWidget {
  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation1;
  Animation<double> _animation2;
  AnimationController _controller;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    Animation curve1 = CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.45,
          curve: Curves.ease,
        ));
    Animation curve2 = CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.55,
          1.0,
          curve: Curves.ease,
        ));

    _animation2 = new Tween<double>(begin: 0, end: 1).animate(curve2);
    _animation1 = new Tween<double>(begin: 0, end: 1).animate(curve1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            right: ((1 - _animation1.value) * 250),
            left: (_animation2.value * 220) + 30,
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Positioned(
            top: _animation1.value == 1
                ? (1 - _animation2.value) * 20
                : _animation1.value * 20,
            left: _animation1.value * 250,
            child: Container(
              width: _animation1.value == 1
                  ? (_animation2.value * 40) + 60
                  : 100 - (_animation1.value * 40),
              height: _animation1.value == 1
                  ? (_animation2.value * 40) + 60
                  : 100 - (_animation1.value * 40),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            top: _animation1.value == 1
                ? (1 - _animation2.value) * 20
                : _animation1.value * 20,
            left: _animation1.value == 1
                ? (_animation2.value * 220) + 30
                : _animation1.value * 30,
            child: Container(
              width: _animation1.value == 1
                  ? (_animation2.value * 40) + 60
                  : 100 - (_animation1.value * 40),
              height: _animation1.value == 1
                  ? (_animation2.value * 40) + 60
                  : 100 - (_animation1.value * 40),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  _controller.reverse();
                },
                child: Container(
                  child: Icon(
                    Icons.person_pin_circle,
                    color: Colors.white,
                    size: 35,
                  ),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  _controller.forward();
                },
                child: Container(
                  child: Icon(
                    Icons.pregnant_woman,
                    color: Colors.white,
                    size: 35,
                  ),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
