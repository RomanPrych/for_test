import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_test/common/di.dart';
import 'package:for_test/fot_test_app_bar_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await setupLocator();
  runApp(const ForTest());
}
