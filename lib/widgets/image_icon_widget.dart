import 'package:flutter/material.dart';

class ImageIconWidget extends StatelessWidget {
  final String imagePath;
  final double size;
  EdgeInsets? margin;
  ImageIconWidget({
    Key? key,
    required this.imagePath,
    required this.size,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(margin: margin, width: size, height: size, child: Image.asset(imagePath));
  }
}
