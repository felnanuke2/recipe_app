import 'package:flutter/material.dart';

import 'package:recipe_app/controllers/step_by_step_controller.dart';

class PlayPauseIconButton extends StatefulWidget {
  const PlayPauseIconButton({
    Key? key,
    required this.stepCotnroller,
  }) : super(key: key);
  final StepByStepCotnroller stepCotnroller;

  @override
  _PlayPauseIconButtonState createState() => _PlayPauseIconButtonState();
}

class _PlayPauseIconButtonState extends State<PlayPauseIconButton> {
  bool isPaused = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.all(0),
        onPressed: _onPressed,
        icon: isPaused
            ? Icon(
                Icons.play_arrow,
                size: 45,
              )
            : Icon(
                Icons.pause_rounded,
                size: 45,
              ));
  }

  _onPressed() {
    isPaused = !isPaused;
    widget.stepCotnroller.pauseCoutDown();
    setState(() {});
  }
}
