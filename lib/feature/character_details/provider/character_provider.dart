import 'package:flutter/cupertino.dart';
import 'package:for_test/common/di.dart';
import 'package:for_test/data/models/person_model.dart';
import 'package:for_test/feature/character_details/use_case_character/get_character_use_case.dart';

class CharacterProvider extends ChangeNotifier {
  CharacterProvider(this.id) {
    //this method starts when we open person page
    init();
  }

  final int id;
  CharacterState state = CharacterState();
  final GetCharacterUseCase getCharacterUseCase =
      locator.get<GetCharacterUseCase>();

  Future<void> init() async {
    //we show loading
    setLoading(true);
    var result = await getCharacterUseCase.call(GetPersonParams(id));
    result.fold(
      //if it is error we call method [error] and give it error text
      (l) => error(l.toString()),
      (r) {
        //if it is ok we show person name in appbar and display person in page and remove loading
        state.titleText = r?.name ?? '';
        state.model = r;
        setLoading(false);
      },
    );
  }

  void error(String value) {
    //if error - we show error text
    state.isError = true;
    state.errorText = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    //add and remove loading when we need
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
