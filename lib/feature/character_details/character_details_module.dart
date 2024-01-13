import 'package:flutter/material.dart';
import 'package:for_test/feature/character_details/character_details_screen.dart';
import 'package:for_test/feature/character_details/provider/character_provider.dart';
import 'package:provider/provider.dart';

class CharacterDetailsModule extends StatelessWidget {
  const CharacterDetailsModule(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CharacterProvider(id),
      child: const CharacterDetailsScreen(),
    );
  }
}
