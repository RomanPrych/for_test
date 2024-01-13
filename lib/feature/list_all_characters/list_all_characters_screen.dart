import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_test/feature/list_all_characters/bloc/list_all_characters_bloc.dart';
import 'package:for_test/feature/list_all_characters/bloc/list_all_characters_state.dart';
import 'package:for_test/feature/list_all_characters/widgets/get_body_list_characters_widget.dart';
import 'package:for_test/feature/widgets_global/app_bar.dart';

class ListAllCharactersScreen extends StatelessWidget {
  const ListAllCharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListAllCharactersBloc, ListAllCharactersState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBarMainWidget(
          onChanges: context.read<ListAllCharactersBloc>().onChanges,
          isCloseIcon: context
              .read<ListAllCharactersBloc>()
              .data
              .controller
              .text
              .isNotEmpty,
          title: 'All characters',
          onClearTap: context.read<ListAllCharactersBloc>().onClearTap,
          controller: context.read<ListAllCharactersBloc>().data.controller,
          onSearchTap: context.read<ListAllCharactersBloc>().getSearchList,
        ),
        body: GetBodyListCharactersWidget(state),
      );
    });
  }
}
