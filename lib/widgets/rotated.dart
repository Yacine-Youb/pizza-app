import 'package:flutter/material.dart';

class RotatedPizza extends StatelessWidget {
  final double angle;

  const RotatedPizza({super.key, required this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,  // Apply the passed angle directly
      child: Image.asset('assets/images/pizza1.png',width: 200,height: 200,),
    );
  }
}
