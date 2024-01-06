import 'package:flutter/material.dart';

class Enemy extends StatelessWidget {
  const Enemy({super.key, required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: size,
      child: Image.asset('assets/img/brick.png',fit: BoxFit.cover,),
    );
  }
}
