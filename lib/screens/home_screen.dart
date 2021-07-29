import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:recipe_app/controllers/home_controller.dart';
import 'package:recipe_app/models/sponacular_recipe_model.dart';
import 'package:recipe_app/repository/spoonacular_repository.dart';
import 'package:recipe_app/widgets/cousines_horizontal_list_widget.dart';
import 'package:recipe_app/widgets/recipe_preview_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SpoonacularRecipeModel> recipesList = [];
  HomeController homeController = HomeController(repository: SpoonacularRepository());
  bool isPullToRefresh = false;
  AnimationController? loadingAnimationController;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _getRandomRecipeList();

    homeController.recipesListStream.listen((event) {
      recipesList = event;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            snap: true,
            floating: true,
            elevation: 0,
            title: Center(
              child: Container(
                height: 58,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                  child: ListTile(
                    leading: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {},
              )
            ],
            backgroundColor: Get.theme.primaryColorLight,
            bottom: PreferredSize(
              child: CousinesHorizontalListWidget(
                key: UniqueKey(),
                scrollController: scrollController,
                homeController: homeController,
                function: _getRandomRecipeList,
              ),
              preferredSize: Size(MediaQuery.of(context).size.width, 40),
            ),
          ),
        ],
        body: RefreshIndicator(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<List<SpoonacularRecipeModel>>(
                            stream: homeController.recipesListStream,
                            initialData: recipesList,
                            builder: (context, snapshot) {
                              if (snapshot.data?.isNotEmpty ?? false) {
                                recipesList = snapshot.data!;
                              }
                              if (MediaQuery.of(context).size.width < 400)
                                return ListView(
                                  children: List.generate(snapshot.data?.length ?? 0, (index) {
                                    var recipeModel = snapshot.data![index];
                                    return RecipePreviewTile(
                                      recipeItem: recipeModel,
                                    );
                                  }),
                                );
                              return GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 16 / 10,
                                children: List.generate(snapshot.data?.length ?? 0, (index) {
                                  var recipeModel = snapshot.data![index];
                                  return RecipePreviewTile(
                                    recipeItem: recipeModel,
                                  );
                                }),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 86,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: FadeInDown(
                        controller: onAnimationControllerAnchor,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            onRefresh: _onRefresh),
      ),
    );
  }

  Future<void> _onRefresh() async {
    isPullToRefresh = true;
    await _getRandomRecipeList();
    isPullToRefresh = false;
  }

  Future<void> _getRandomRecipeList() async {
    if (isPullToRefresh) {
    } else {
      loadingAnimationController?.forward();
    }
    await homeController.getRandomRecipes();
    loadingAnimationController?.reverse();
  }

  onAnimationControllerAnchor(AnimationController? controller) =>
      this.loadingAnimationController = controller;
}
