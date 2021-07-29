import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:recipe_app/constants/cousies_list.dart';
import 'package:recipe_app/controllers/home_controller.dart';

class CousinesHorizontalListWidget extends StatefulWidget {
  final HomeController homeController;
  final Function() function;
  ScrollController? scrollController;
  CousinesHorizontalListWidget({
    Key? key,
    required this.homeController,
    required this.function,
    this.scrollController,
  }) : super(key: key);

  @override
  _CousinesHorizontalListWidgetState createState() => _CousinesHorizontalListWidgetState();
}

class _CousinesHorizontalListWidgetState extends State<CousinesHorizontalListWidget> {
  int selecteIndex = 0;
  @override
  void initState() {
    selecteIndex = cousinesList.indexOf(widget.homeController.cousine ?? 'All');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView(
        controller: widget.scrollController,
        padding: EdgeInsets.symmetric(horizontal: 12),
        children: List.generate(cousinesList.length, (index) {
          bool isSelected = index == selecteIndex;
          return InkWell(
            onTap: () => _selectIndex(index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                color: isSelected ? Theme.of(context).primaryColor : null,
                alignment: Alignment.center,
                child: Text(
                  cousinesList[index],
                  style: GoogleFonts.nunito(
                      color: isSelected ? Colors.white : null,
                      fontWeight: isSelected ? FontWeight.bold : null),
                ),
              ),
            ),
          );
        }),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  _selectIndex(int index) {
    selecteIndex = index;
    if (index == 0) {
      widget.homeController.cousine = null;
    } else {
      widget.homeController.cousine = cousinesList[index];
    }
    widget.function.call();
    setState(() {});
  }
}
