import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:recipe_app/models/sponacular_recipe_model.dart';
import 'package:recipe_app/models/spoonacular_igredients_and_equipments.dart';
import 'package:recipe_app/screens/recipe_step_screen.dart';

class RecipeScreen extends StatefulWidget {
  final SpoonacularRecipeModel recipeModel;
  const RecipeScreen({
    Key? key,
    required this.recipeModel,
  }) : super(key: key);

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        height: 45,
        width: 220,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
          onPressed: () {
            Get.to(
                () => RecipeStepScreen(instructionsList: widget.recipeModel.analyzedInstructions));
          },
          child: Text('Let\'s Cooking'),
        ),
      ),
      backgroundColor: Get.theme.primaryColorLight,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0,
              title: Text(
                widget.recipeModel.title,
                style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      size: 38,
                    ))
              ],
            ),
            SliverToBoxAdapter(
              child: Hero(
                tag: widget.recipeModel.image ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22), bottomRight: Radius.circular(22)),
                  child: Container(
                    width: 340,
                    child: AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Image.network(
                        'https://spoonacular.com/recipeImages/${widget.recipeModel.id}-636x393.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TabBar(
                  unselectedLabelStyle: GoogleFonts.nunito(color: Colors.white, fontSize: 16),
                  labelStyle: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                  labelPadding: EdgeInsets.symmetric(vertical: 20),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: tabController,
                  tabs: [
                    Text(
                      'Igredients' + ' (${widget.recipeModel.extendedIngredients.length})',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Equipments' + ' (${_getEquipmentList.length})',
                      textAlign: TextAlign.center,
                    )
                  ]),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(controller: tabController, children: [
                  ListView(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 100),
                    children: List.generate(widget.recipeModel.extendedIngredients.length, (index) {
                      var igredientItem = widget.recipeModel.extendedIngredients[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                        color: Colors.white.withOpacity(0.7),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: ListTile(
                            leading: igredientItem.image == null
                                ? Container(
                                    width: 60,
                                    height: 60,
                                    child: Icon(Icons.food_bank_sharp),
                                  )
                                : Container(
                                    margin: EdgeInsets.all(4),
                                    child: ClipRRect(
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
                                  ),
                            title: Text(igredientItem.name ?? ''),
                            trailing: Text(igredientItem.amount.toStringAsFixed(2) +
                                ' ' +
                                igredientItem.unit.toString().replaceAll('null', '')),
                          ),
                        ),
                      );
                    }),
                  ),
                  ListView(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 100),
                    children: List.generate(_getEquipmentList.length, (index) {
                      var equipmentItem = _getEquipmentList[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                        color: Colors.white.withOpacity(0.7),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: ListTile(
                            leading: equipmentItem.image == null
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.all(4),
                                    child: ClipRRect(
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
                                  ),
                            title: Text(equipmentItem.name),
                          ),
                        ),
                      );
                    }),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Equipment> get _getEquipmentList {
    List<Equipment> equipmentList = [];
    widget.recipeModel.analyzedInstructions.forEach((element) {
      element.steps.forEach((element) {
        equipmentList.addAll(element.equipment);
      });
    });
    equipmentList.removeEquals();
    return equipmentList;
  }
}

extension EquipmentExtension on List<Equipment> {
  void removeEquals() {
    Map<String, int> mapCount = {};
    this.forEach((element) {
      if (mapCount.containsKey(element.name)) {
        mapCount[element.name] = mapCount[element.name]! + 1;
      } else {
        mapCount[element.name] = 1;
      }
    });
    mapCount.removeWhere((key, value) => value < 2);
    this.removeWhere((element) {
      bool remove = mapCount.containsKey(element.name);
      if (remove) {
        mapCount.remove(element.name);
      }
      return remove;
    });
  }
}
