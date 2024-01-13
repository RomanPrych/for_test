import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_test/feature/list_all_characters/bloc/list_all_characters_bloc.dart';
import 'package:for_test/feature/list_all_characters/list_all_characters_screen.dart';


class ListAllCharactersModule extends StatelessWidget {
  const ListAllCharactersModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListAllCharactersBloc>(
      create: (_) => ListAllCharactersBloc(),
      child: const ListAllCharactersScreen(),
    );
  }
}
