import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HabitTile extends StatelessWidget {
  // Declaring variables
  final String habitName;
  final VoidCallback playTap;
  final VoidCallback settingsTap;
  final int timeSpent, timeGoal;
  final bool habitState;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.playTap,
    required this.settingsTap,
    required this.timeSpent,
    required this.timeGoal,
    required this.habitState,
  }) : super(key: key);

  // Convert seconds to min: eg. 65 sec = 1:05 mins
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);

    // if seconds is 1 digit ,place a 0 infront
    if (secs.length == 1) {
      secs = '0' + secs;
    }

    // if mins is 1 digit
    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }

    return mins + ':' + secs;
  }

  // Calculating progress percentage
  double percentCompleted() {
    return timeSpent / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: playTap,
                  child: Container(
                    height: 60,
                    width: 60,
                    // color: Colors.blueGrey,
                    child: Stack(
                      children: [
                        // Progress circle
                        CircularPercentIndicator(
                          radius: 30,
                          percent:
                              percentCompleted() < 1 ? percentCompleted() : 1,
                          progressColor: percentCompleted() > 0.5
                              ? (percentCompleted() > 0.75
                                  ? Colors.green
                                  : Colors.orangeAccent)
                              : Colors.red,
                        ),
                        // Play or Pause button
                        Center(
                          child: Icon(
                            habitState ? FontAwesome5.pause : FontAwesome5.play,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // habit name
                    Text(
                      habitName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    //Space between
                    const SizedBox(
                      height: 4,
                    ),
                    // Progress
                    Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      formatToMinSec(timeSpent) +
                          '/' +
                          timeGoal.toString() +
                          ' = ' +
                          (percentCompleted() * 100).toStringAsFixed(0) +
                          '%',
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: settingsTap,
              child: Icon(MfgLabs.menu),
            ),
          ],
        ),
      ),
    );
  }
}
