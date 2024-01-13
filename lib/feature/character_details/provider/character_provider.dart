import 'package:flutter/cupertino.dart';
import 'package:for_test/common/di.dart';
import 'package:for_test/data/models/person_model.dart';
import 'package:for_test/feature/character_details/use_case_character/get_character_use_case.dart';

class CharacterProvider extends ChangeNotifier {
  CharacterProvider(this.id) {
    init();
  }

  final int id;
  CharacterState state = CharacterState();
  final GetCharacterUseCase getCharacterUseCase =
      locator.get<GetCharacterUseCase>();

  Future<void> init() async {
    setLoading(true);
    var result = await getCharacterUseCase.call(GetPersonParams(id));
    result.fold((l) => error(l.toString()), (r) {
      state.titleText = r?.name ?? '';
      state.model = r;
      setLoading(false);
    });
  }

  void error(String value) {
    state.isError = true;
    state.errorText = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    state.isLoading = value;
    notifyListeners();
  }
}

class CharacterState {
  String titleText = '';
  String errorText = '';
  bool isLoading = true;
  bool isError = false;
  PersonModel? model;
}
