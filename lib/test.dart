import 'package:flutter/material.dart';


class PointsBar extends StatelessWidget {
  final int maxValue;
  final int currentValue;

  const PointsBar({super.key, required this.maxValue, required this.currentValue});

  @override
  Widget build(BuildContext context) {
    double progress = (currentValue / maxValue).clamp(0.0, 1.0);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 20,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: Stack(
            children: [
              Container(
                width: 200 * progress,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
