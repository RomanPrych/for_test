import 'package:flutter/material.dart';
import 'package:for_test/feature/list_all_characters/bloc/list_all_characters_state.dart';
import 'package:for_test/feature/widgets_global/loading_widget.dart';
import 'package:for_test/feature/widgets_global/person_item.dart';

class GetBodyListCharactersWidget extends StatelessWidget {
  const GetBodyListCharactersWidget(this.state, {super.key});

  final ListAllCharactersState state;

  @override
  Widget build(BuildContext context) {
    if (state is ShowLoadingMain) {
      return const Center(child: LoadingWidget());
    } else if (state is ShowListPersons) {
      List<Widget?> listWidgets = [];
      ShowListPersons stateThis = (state as ShowListPersons);
      listWidgets = stateThis.data.listPersons
          .map((e) => PersonItem(
                e,
                0xFF2C2E30,
                false,
              ))
          .toList();
      if (stateThis.data.isLoadingListPersons) {
        listWidgets = [
          ...listWidgets,
          const Center(
            child: LoadingWidget(
              width: 30,
              height: 30,
            ),
          ),
        ];
      }

      return ListView.builder(
        controller: stateThis.data.scrollController,
        itemCount: listWidgets.length,
        itemBuilder: (context, i) => listWidgets[i],
      );
    } else if (state is ShowListPersonsFromSearch) {
      List<Widget?> listWidgets = [];
      ShowListPersonsFromSearch stateThis =
          (state as ShowListPersonsFromSearch);
      listWidgets = stateThis.data.listPersonsFromSearch
          .map((e) => PersonItem(
                e,
                0xFF6A4DBA,
                true,
              ))
          .toList();
      if (stateThis.data.isLoadingListPersonsFromSearch) {
        listWidgets = [
          ...listWidgets,
          const Center(
            child: LoadingWidget(
              width: 30,
              height: 30,
            ),
          ),
          ];
      }

      return ListView.builder(
        itemCount: listWidgets.length,
        itemBuilder: (context, i) => listWidgets[i],
      );
    } else {
      String error = 'some error';
      if (state is Error) {
        error = (state as Error).errorText;
      }
      return Center(child: Text('Error:\n$error'));
    }
  }
}
