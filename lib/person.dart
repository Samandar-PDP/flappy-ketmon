import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  const Person({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/img/img.png',
      width: 80,
      height: 80,
      fit: BoxFit.fill
    );
  }
}
