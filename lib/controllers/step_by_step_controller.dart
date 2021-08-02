import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class StepByStepCotnroller {
  Completer? _cancelCoutdownCompleter;
  PauseController _pauseController = PauseController();
  bool inCount = false;
  var _inCountSC = StreamController<bool>.broadcast();
  var _timerCoutDownSC = StreamController<Duration?>.broadcast();

  Stream<bool> get getInCountSC => _inCountSC.stream;
  Stream<Duration?> get getTimerCoutDownSC => _timerCoutDownSC.stream;

  void dispose() {
    _timerCoutDownSC.close();
    _inCountSC.close();

    _cancelCoutdownCompleter?.complete();
  }

  void pauseCoutDown() {
    if (_pauseController.pauseCoutdownCompleter != null) {
      if (!_pauseController.pauseCoutdownCompleter!.isCompleted) {
        _pauseController.pauseCoutdownCompleter?.complete();
        _pauseController.pauseCoutdownCompleter = null;
        return;
      }
    } else {
      _pauseController.pauseCoutdownCompleter = Completer();
    }
  }

  cancelCoutDown() {
    _cancelCoutdownCompleter?.complete(true);
  }

  pickTime() async {
    var pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );
    if (_cancelCoutdownCompleter == null) {
      _cancelCoutdownCompleter = Completer();
    } else {
      if (_cancelCoutdownCompleter?.isCompleted ?? false) {
        _cancelCoutdownCompleter = Completer();
      } else {
        _cancelCoutdownCompleter?.complete(true);
      }
    }
    if (pickedTime != null) {
      inCount = true;
      _inCountSC.add(inCount);
      _startCount(pickedTime.hour, pickedTime.minute, this._timerCoutDownSC,
          _cancelCoutdownCompleter!, _pauseController);
      _cancelCoutdownCompleter?.future.then((value) {
        inCount = false;
        _inCountSC.add(inCount);
        _timerCoutDownSC.add(null);
      });
    }
  }
}

class PauseController {
  Completer? pauseCoutdownCompleter;
}

_startCount(int hours, int minuts, StreamController streamController, Completer cancelableCompleter,
    PauseController pauseCoutDown) async {
  var duration = Duration(minutes: minuts, hours: hours);
  streamController.add(duration);

  bool cancel = false;
  cancelableCompleter.future.then((value) => cancel = true);

  for (var currentsecond = duration.inSeconds; currentsecond >= 0; currentsecond--) {
    if (pauseCoutDown.pauseCoutdownCompleter != null) {
      await pauseCoutDown.pauseCoutdownCompleter!.future;
    }
    if (cancel) {
      return;
    }
    streamController.add(Duration(seconds: currentsecond));
    var second = Duration(seconds: 1);
    await Future.delayed(second);
  }
  cancelableCompleter.complete(true);
}
