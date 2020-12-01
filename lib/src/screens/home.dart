import 'dart:math';

import 'package:box_animation/src/widgets/cat.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> flapsAnimation;
  AnimationController flapsController;

  void initState() {
    super.initState();
    catController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );

    flapsController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    flapsAnimation = Tween(begin: 0.0, end: 3.14).animate(
      CurvedAnimation(
        parent: flapsController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation!'),
      ),
      backgroundColor: Color(0xffecf0f1),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          left: 0.0,
          right: 0.0,
        );
      },
      child: Cat(),
    );
  }

  void onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }
  }

  Widget buildBox() {
    return Container(
      width: 200.0,
      height: 170.0,
      color: Color(0xff3498db),
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 7.0,
      top: 3.0,
      child: Transform.rotate(
        angle: pi * 0.6,
        alignment: Alignment.topLeft,
        child: Container(
          height: 7.0,
          width: 90.0,
          color: Color(0xff3498db),
        ),
      ),
    );
  }
}
