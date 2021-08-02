import 'package:flutter/material.dart';

class TimeClock extends TimeOfDay {
  final int hour;
  final int minuts;
  final int seconds;

  TimeClock(
    this.hour,
    this.minuts,
    this.seconds,
  ) : super(hour: hour, minute: minuts);
}
