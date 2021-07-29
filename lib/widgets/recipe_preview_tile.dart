import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:recipe_app/models/sponacular_recipe_model.dart';
import 'package:recipe_app/widgets/image_icon_widget.dart';
import 'package:shimmer/shimmer.dart';

class RecipePreviewTile extends StatelessWidget {
  final SpoonacularRecipeModel recipeItem;
  const RecipePreviewTile({
    Key? key,
    required this.recipeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.network(
                  recipeItem.image ?? '',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return FadeIn(child: child);
                    return SizedBox(
                      child: Shimmer.fromColors(
                          child: Container(
                            color: Get.theme.primaryColorLight,
                          ),
                          baseColor: Get.theme.primaryColorLight,
                          highlightColor: Colors.white),
                    );
                  },
                )),
            Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.end,
                    children: [
                      if (recipeItem.vegetarian)
                        ImageIconWidget(
                          imagePath: 'assets/vegetarian-icon.png',
                          size: 40,
                        ),
                      if (recipeItem.vegan)
                        ImageIconWidget(
                          imagePath: 'assets/vegan-icon.png',
                          size: 40,
                        ),
                      if (recipeItem.dairyFree)
                        ImageIconWidget(
                          imagePath: 'assets/lactose-free-icon.png',
                          size: 40,
                        ),
                      if (recipeItem.glutenFree)
                        ImageIconWidget(
                          imagePath: 'assets/gluten-free-icon.png',
                          size: 40,
                        ),
                      if (recipeItem.veryHealthy)
                        ImageIconWidget(
                          imagePath: 'assets/healthy-icon.png',
                          size: 40,
                        ),
                      if (recipeItem.cheap)
                        ImageIconWidget(
                          imagePath: 'assets/cheap-icon.png',
                          size: 40,
                        ),
                      if (recipeItem.sustainable)
                        ImageIconWidget(
                          imagePath: 'assets/sustainable-icon.png',
                          size: 40,
                        ),
                    ],
                  ),
                )),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Container(
                          width: 290,
                          color: Colors.black.withOpacity(0.4),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(recipeItem.title,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Divider(
                                color: Colors.white.withOpacity(0.6),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      ImageIconWidget(
                                        imagePath: 'assets/chronometer-icon.png',
                                        size: 20,
                                        margin: EdgeInsets.only(right: 6),
                                      ),
                                      Text(recipeItem.readyInMinutes.toString(),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ImageIconWidget(
                                        imagePath: 'assets/serve-icon.png',
                                        size: 20,
                                        margin: EdgeInsets.only(right: 6),
                                      ),
                                      Text(recipeItem.servings.toString(),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ImageIconWidget(
                                        imagePath: 'assets/health-icon.png',
                                        size: 20,
                                        margin: EdgeInsets.only(right: 6),
                                      ),
                                      Text(recipeItem.healthScore.toStringAsFixed(0),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
