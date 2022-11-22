import 'dart:io';

import 'package:flutter/material.dart';

class DetailsFillVm extends ChangeNotifier {
  File? _imagePath;

  File? get imagePath => _imagePath;

  set imagePath(File? value) {
    _imagePath = value;
    notifyListeners();
  }
}
