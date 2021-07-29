import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/app_settings/hive_app_settings.dart';
import 'package:recipe_app/screens/home_screen.dart';

class AppPresentationScreen extends StatelessWidget {
  const AppPresentationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/presentation_food.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(top: 90, bottom: 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: List.generate(
                            10 + 1, (index) => Colors.black.withOpacity((1 - index / 10))),
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Cozinhe Como Um Chefe',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Econtre a receita ideal com os igredientes da sua geladeira ou crie uma lista de compras apartir de uma receita',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito().copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Container(
                        padding: EdgeInsetsDirectional.zero,
                        width: 250,
                        height: 70,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(padding: EdgeInsets.all(8)),
                            onPressed: () {
                              HiveAppSettings.onFirstLaunchConclusion();
                              Get.offAll(() => HomeScreen());
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.arrow_forward_ios_rounded),
                                ),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  'Começar',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                )))
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
