import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_games/enemy.dart';
import 'package:flutter_games/person.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double personY = 0;
  double time = 0;
  double height = 0;
  double initialHeight = personY;
  bool isGameStarted = false;
  static double enemyXOne = -1.3;
  double enemyXTwo = enemyXOne + 2;
  int score = 0;
  bool isBarrierTouched = false;
  bool isVisible = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = personY;
    });
  }


  void startGame() {
    isGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        personY = initialHeight - height;
      });

      setState(() {
        if (enemyXOne < -2) {
          enemyXOne += 3.5;
          ++score;
        } else {
          enemyXOne -= 0.05;
        }
      });

      setState(() {
        if (enemyXTwo < -2) {
          ++score;
          enemyXTwo += 3.5;
        } else {
          enemyXTwo -= 0.05;
        }
      });

      print('$personY per');
      print('$enemyXOne');
      print('$enemyXTwo');

      // if((enemyXOne < 0.30 && personY > 0.4) || (enemyXTwo < 0.30 && personY > -0.4)) {
      //   setState(() {
      //     isVisible = true;
      //   });
      // }

      if (personY > 1) {
        timer.cancel();
        time = 0;
        isGameStarted = false;
        _showDialog();
      }
    });
  }


  _showDialog() {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Game over'),
        actions: [
          ElevatedButton(onPressed: () {
            _resetGame();
            Navigator.of(context).pop();
          }, child: Text("OK"))
        ],
      ));
  }

  void _resetGame() {
    setState(() {
      personY = 0;
      time = 0;
      height = 0;
      score = 0;
      initialHeight = 0;
      enemyXOne = 1.3;
      enemyXTwo = enemyXOne + 2;
      isBarrierTouched =false;
      isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isGameStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, personY),
                      duration: const Duration(milliseconds: 10),
                      color: Colors.blue,
                      child: const Person(),
                    ),
                    Container(
                      alignment: Alignment(1, -0.7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/img_1.png',
                            width: 60,
                            height: 60,
                          ),
                          Image.asset(
                            'assets/img/img_1.png',
                            width: 60,
                            height: 60,
                          ),
                          Image.asset(
                            'assets/img/img_2.png',
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, -0.2),
                      child: isGameStarted
                          ? Text("")
                          : Text(
                              "TAP TO PLAY",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(enemyXOne, 1.1),
                      duration: Duration(milliseconds: 6),
                      child: Enemy(
                        size: 180,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(enemyXOne, -1.1),
                      duration: Duration(milliseconds: 6),
                      child: Enemy(
                        size: 220,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(enemyXTwo, 1.1),
                      duration: Duration(milliseconds: 6),
                      child: Enemy(
                        size: 200,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(enemyXTwo, -1.1),
                      duration: Duration(milliseconds: 6),
                      child: Enemy(
                        size: 190,
                      ),
                    ),
                    if(isVisible)
                      Container(
                        alignment: Alignment(1,1),
                        color: Colors.red,
                        width: 100,
                        height: 100,
                      )
                  ],
                )
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SCORE',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(
                        score.toString(),
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
