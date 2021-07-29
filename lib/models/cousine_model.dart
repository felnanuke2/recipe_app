import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';

class CousineModel {
  final String originalName;
  Completer<String> translatadeName = Completer<String>();
  CousineModel({
    required this.originalName,
  }) {
    _getTranslation();
  }
  _getTranslation() async {
    var translator = GoogleTranslator();
    try {
      var translation = await translator.translate(originalName, from: 'en', to: 'pt');
      translatadeName.complete(translation.text);
    } catch (e) {}
  }
}
