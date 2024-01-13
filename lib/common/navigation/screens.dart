import 'package:flutter/material.dart';
import 'package:for_test/common/navigation/args/person_args.dart';
import 'package:for_test/common/navigation/names.dart';
import 'package:for_test/feature/character_details/character_details_module.dart';
import 'package:for_test/feature/list_all_characters/list_all_characters_module.dart';

Widget getScreen(String? name, {Object? arguments}) {
  switch (name) {
    case listAllCharacters:
      return const ListAllCharactersModule();
    case characterDetails:
      final args = arguments as PersonArgs;
      return CharacterDetailsModule(args.id);
    default:
      return const SizedBox.shrink();
  }
}
