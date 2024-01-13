import 'package:equatable/equatable.dart';
import 'package:for_test/feature/list_all_characters/bloc/list_all_characters_bloc.dart';

abstract class ListAllCharactersState extends Equatable {
  @override
  List<Object?> get props => [double.nan];
}

class ShowLoadingMain extends ListAllCharactersState {
  @override
  List<Object> get props => [double.nan];
}

class ShowListPersons extends ListAllCharactersState {
  ShowListPersons({required this.data});

  final DataListAllCharacters data;

  @override
  List<Object> get props => [
        double.nan
      ];
}

class ShowListPersonsFromSearch extends ListAllCharactersState {
  ShowListPersonsFromSearch({required this.data});

  final DataListAllCharacters data;

  @override
  List<Object> get props => [
    double.nan
      ];
}

class Error extends ListAllCharactersState {
  Error(this.errorText);

  final String errorText;

  @override
  List<Object> get props => [
        errorText,
      ];
}
