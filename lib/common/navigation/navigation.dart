import 'package:flutter/material.dart';
import 'package:for_test/common/navigation/args/person_args.dart';
import 'package:for_test/common/navigation/names.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Nav {
  static pop() => Navigator.of(navigatorKey.currentContext!).pop();

  static popUntil(String route) => Navigator.of(navigatorKey.currentContext!)
      .popUntil(ModalRoute.withName(route));

  static openAllCharactersListScreen() =>
      Navigator.of(navigatorKey.currentContext!).pushNamed(listAllCharacters);

  static openCharacterDetailScreen(int id) =>
      Navigator.of(navigatorKey.currentContext!).pushNamed(
        characterDetails,
        arguments: PersonArgs(id),
      );
}
