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

  void initState() {
    super.initState();
    catController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    catAnimation = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: catController,
      curve: Curves.easeIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation!'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            children: [
              buildCatAnimation(),
              buildBox(),
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
      height: 200.0,
      color: Color(0xffc0392b),
    );
  }
}
