import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:recipe_app/controllers/step_by_step_controller.dart';

import 'package:recipe_app/models/spoonacular_analyzed_instructions.dart';
import 'package:recipe_app/widgets/play_pause_icon_button.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class RecipeStepScreen extends StatefulWidget {
  const RecipeStepScreen({
    Key? key,
    required this.instructionsList,
  }) : super(key: key);
  final List<AnalyzedInstructions> instructionsList;

  @override
  _RecipeStepScreenState createState() => _RecipeStepScreenState();
}

class _RecipeStepScreenState extends State<RecipeStepScreen> with TickerProviderStateMixin {
  var _progressController = StreamController<double>.broadcast();

  final PageController _pageController = PageController();

  int _currentPage = 0;
  final StepByStepCotnroller stepCotnroller = StepByStepCotnroller();

  @override
  void dispose() {
    _progressController.close();
    stepCotnroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: stepCotnroller.getInCountSC,
        initialData: stepCotnroller.inCount,
        builder: (context, snapshotInCount) {
          return Scaffold(
            floatingActionButtonLocation:
                stepCotnroller.inCount ? FloatingActionButtonLocation.centerFloat : null,
            floatingActionButton: StreamBuilder<Duration?>(
                stream: stepCotnroller.getTimerCoutDownSC,
                builder: (context, snapshotTimerCoutDown) {
                  return AnimatedContainer(
                    width: stepCotnroller.inCount ? 280 : 60,
                    height: 60,
                    duration: Duration(milliseconds: 400),
                    child: stepCotnroller.inCount
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28))),
                            onPressed: () {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PlayPauseIconButton(stepCotnroller: stepCotnroller),
                                if (snapshotTimerCoutDown.hasData)
                                  Text(
                                    StopWatchTimer.getDisplayTime(
                                        snapshotTimerCoutDown.data?.inMilliseconds ??
                                            Duration().inMilliseconds,
                                        milliSecond: false),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                IconButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: stepCotnroller.cancelCoutDown,
                                    icon: Icon(
                                      Icons.stop_rounded,
                                      color: Colors.red,
                                      size: 45,
                                    )),
                              ],
                            ))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(shape: CircleBorder()),
                            onPressed: stepCotnroller.pickTime,
                            child: Icon(Icons.timer),
                          ),
                  );
                }),
            backgroundColor: Get.theme.primaryColorLight,
            body: SafeArea(
                child: Column(
              children: [
                StreamBuilder<double>(
                    stream: _progressController.stream,
                    initialData: 1 / widget.instructionsList[0].steps.length,
                    builder: (context, snapshotProgress) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: LinearProgressIndicator(
                                value: snapshotProgress.data!,
                                minHeight: 20,
                              ),
                            )),
                            Text(
                              '   ${widget.instructionsList[0].steps.length} Steps',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      );
                    }),
                Expanded(
                    child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: widget.instructionsList[0].steps.length,
                  itemBuilder: (context, index) {
                    var stepItem = widget.instructionsList[0].steps[index];
                    return SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Step ${stepItem.number}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            if (stepItem.equipment.isNotEmpty)
                              Text(
                                'Equipments:',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            if (stepItem.equipment.isNotEmpty)
                              SizedBox(
                                height: 15,
                              ),
                            Wrap(
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              runSpacing: 4,
                              spacing: 4,
                              children: List.generate(stepItem.equipment.length, (index) {
                                var equipmentItem = stepItem.equipment[index];

                                return Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(22),
                                      child: Container(
                                        color: Colors.white,
                                        width: 60,
                                        height: 60,
                                        padding: EdgeInsets.all(8),
                                        child: Image.network(
                                          'https://spoonacular.com/cdn/equipment_100x100/${equipmentItem.image}',
                                          errorBuilder: (context, error, stackTrace) =>
                                              Icon(Icons.food_bank),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                        width: 60,
                                        child: Text(
                                          equipmentItem.name,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        )),
                                  ],
                                );
                              }),
                            ),
                            if (stepItem.ingredients.isNotEmpty)
                              SizedBox(
                                height: 20,
                              ),
                            if (stepItem.ingredients.isNotEmpty)
                              Text(
                                'Igredients:',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            if (stepItem.ingredients.isNotEmpty) SizedBox(height: 15),
                            Wrap(
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              runSpacing: 4,
                              spacing: 4,
                              children: List.generate(stepItem.ingredients.length, (index) {
                                var igredientItem = stepItem.ingredients[index];

                                return Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(22),
                                      child: Container(
                                        color: Colors.white,
                                        width: 60,
                                        height: 60,
                                        padding: EdgeInsets.all(8),
                                        child: Image.network(
                                          'https://spoonacular.com/cdn/ingredients_100x100/${igredientItem.image}',
                                          errorBuilder: (context, error, stackTrace) =>
                                              Icon(Icons.food_bank),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                        width: 60,
                                        child: Text(
                                          igredientItem.name,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        )),
                                  ],
                                );
                              }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Card(
                                child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                    child: Text(stepItem.step))),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ))
              ],
            )),
          );
        });
  }

  _onPageChanged(int value) {
    defineProgressIndicatorProgress(value);
  }

  defineProgressIndicatorProgress(int value) {
    var animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 650));
    var animation = Tween<double>(begin: _currentPage.toDouble(), end: value.toDouble())
        .animate(CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
    animationController.forward();
    animation.addListener(() {
      _currentPage = animation.value.round();
      _progressController.add((animation.value + 1) / widget.instructionsList[0].steps.length);
    });
  }
}
