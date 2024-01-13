import 'package:flutter/material.dart';
import 'package:for_test/common/navigation/names.dart';
import 'package:for_test/common/navigation/navigation.dart';
import 'package:for_test/common/navigation/route.dart';
import 'package:for_test/common/navigation/screens.dart';
import 'package:for_test/common/theme/app_theme.dart';

class ForTest extends StatelessWidget {
  const ForTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ForTest',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      routes: {
        listAllCharacters: (BuildContext context) => getScreen(listAllCharacters),
      },
      navigatorKey: navigatorKey,
      initialRoute: listAllCharacters,
      onGenerateRoute: (settings) => getPageRoute(settings.name ?? '/', arguments: settings.arguments),
    );
  }
}
