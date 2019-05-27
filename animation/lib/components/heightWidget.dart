import 'package:flutter/material.dart';

class HeightWidget extends StatefulWidget {
  @override
  _HeightWidgetState createState() => _HeightWidgetState();
}

class _HeightWidgetState extends State<HeightWidget>
    with SingleTickerProviderStateMixin {
  FixedExtentScrollController _controller;
  Animation _animation1;
  Animation _animation2;
  AnimationController _animationController;
  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: 2);
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    Animation curve1 = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.1,
        0.7,
        curve: Curves.ease,
      ),
    );
    Animation curve2 = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.ease,
      ),
    );

    _animation1 = new Tween(begin: 0.0, end: 1.0).animate(curve1);
    _animation2 = new Tween(begin: 0.0, end: 1.0).animate(curve2)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: ((1 - _animation2.value) * 50) + 200,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: _animationController.value > 0.2
                          ? _animation2.value * 100
                          : (1 - _animation1.value) * 100,
                      width: _animationController.value > 0.2
                          ? (1 + _animation1.value) * 75
                          : 75,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.blue),
                          top: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _animationController.value >= 0.4
                          ? _animation1.value * 50
                          : 0,
                    ),
                    Container(
                      height: _animation2.value * 100,
                      width: _animationController.value > 0.2
                          ? (1 + _animation1.value) * 75
                          : 75,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.blue),
                          top: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                list1(),
                list(),
                // /list(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget list() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 500,
      child: Opacity(
        opacity: _animation2.value,
        child: ListWheelScrollView(
          diameterRatio: 10,
          controller: _controller,
          physics: FixedExtentScrollPhysics(),
          useMagnifier: false,
          itemExtent: 100,
          children: List.generate(
            12,
            (index) {
              return Container(
                height: 100,
                child: Center(
                  child: Text(
                    "${(index).toString()}''",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget list1() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 500,
      child: Opacity(
        opacity: _animation2.value,
        child: ListWheelScrollView(
          diameterRatio: 10,
          controller: _controller,
          physics: FixedExtentScrollPhysics(),
          useMagnifier: false,
          itemExtent: 100,
          children: List.generate(
            50,
            (index) {
              return Container(
                height: 100,
                child: Center(
                  child: Text(
                    "${(index).toString()}'",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
