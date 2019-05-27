import 'package:flutter/material.dart';

class FitnessWidget extends StatefulWidget {
  @override
  _FitnessWidgetState createState() => _FitnessWidgetState();
}

class _FitnessWidgetState extends State<FitnessWidget>
    with TickerProviderStateMixin {
  Animation _animation1;
  Animation _animation2;
  Animation _animation3;

  AnimationController _controller1;

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();

    _controller1 = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    Animation curve1 = CurvedAnimation(
      parent: _controller1,
      curve: Interval(
        0.0,
        0.3,
        curve: Curves.ease,
      ),
    );
    Animation curve2 = CurvedAnimation(
      parent: _controller1,
      curve: Interval(
        0.3,
        0.6,
        curve: Curves.bounceOut,
      ),
    );
    Animation curve3 = CurvedAnimation(
      parent: _controller1,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.ease,
      ),
    );

    _animation1 = new Tween(begin: 0.0, end: 1.0).animate(curve1);
    _animation3 = new Tween(begin: 0.0, end: 1.0).animate(curve3);

    _animation2 = new Tween(begin: 0.02, end: 1.0).animate(curve2)
      ..addListener(() {
        setState(() {});
      });
    _controller1.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            width: 100,
            height: 100,
            left: 150 - (_animation1.value * 55),
            top: 250 - (_animation1.value * 75),
            child: Center(
              child: InkWell(
                child: Container(
                  child: Center(
                    child: Text(
                      "Muscle\nGain",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: _animation3.value * 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  width: (_animation2.value * 100),
                  height: (_animation2.value * 100),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(32, 56, 110, 1),
                    borderRadius: BorderRadius.circular(75),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            width: 100,
            height: 100,
            left: 150 + (_animation1.value * 55),
            top: 250 - (_animation1.value * 25),
            child: Center(
              child: InkWell(
                child: Container(
                  child: Center(
                    child: Text(
                      "Weight\nLoss",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: _animation3.value * 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  width: _animation2.value * 100,
                  height: _animation2.value * 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(32, 56, 110, 1),
                    borderRadius: BorderRadius.circular(75),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            width: 100,
            height: 100,
            left: 150 - (_animation1.value * 55),
            top: 250 + (_animation1.value * 40),
            child: Center(
              child: InkWell(
                child: Container(
                  child: Center(
                    child: Text(
                      "Toning",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: _animation3.value * 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  width: _animation2.value * 100,
                  height: _animation2.value * 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(32, 56, 110, 1),
                    borderRadius: BorderRadius.circular(75),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            width: 100,
            height: 100,
            left: 150 + (_animation1.value * 55),
            top: 250 + (_animation1.value * 90),
            child: Center(
              child: InkWell(
                child: Container(
                  child: Center(
                    child: Text(
                      "Sports\nSpecific",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: _animation3.value * 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  width: _animation2.value * 100,
                  height: _animation2.value * 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(32, 56, 110, 1),
                    borderRadius: BorderRadius.circular(75),
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
