import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:habit_tracker/utils/habit_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Overall Habit list
  List habitList = [
    // [habitName,habitState,timeSpent(sec),timeGoal(min)]
    ['Exercise', false, 0, 10],
    ['Code', false, 0, 10],
    ['Study', false, 0, 10],
    ['Project', false, 0, 10],
  ];

  void habitStarted(int index) {
    // Grab the current time
    var startTime = DateTime.now();

    // Including the already elapsed time
    int elapsedTime = habitList[index][2];

    // habit started or stopped
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });
    if (habitList[index][1]) {
      // Start the timer
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          // Check the timer - when stopped
          if (!habitList[index][1]) {
            timer.cancel();
          }
          // Calculate the time elapsed by comparing
          //current time and start time
          var currentTime = DateTime.now();
          habitList[index][2] = elapsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Shows settings' + habitList[index][0]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('STAY FOCUSED!'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesome5.plus,
              size: 20,
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: habitList.length,
          itemBuilder: ((context, index) {
            return HabitTile(
              habitName: habitList[index][0],
              playTap: () {
                habitStarted(index);
              },
              settingsTap: () {
                settings(index);
              },
              habitState: habitList[index][1],
              timeSpent: habitList[index][2],
              timeGoal: habitList[index][3],
            );
          })),
    );
  }
}
