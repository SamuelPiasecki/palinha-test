import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:palinha_test/src/app_widget.dart';
import 'src/app_module.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
