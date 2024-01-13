import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_test/common/di.dart';
import 'package:for_test/common/utils/msg_toast_util.dart';
import 'package:for_test/data/models/person_model.dart';
import 'package:for_test/feature/list_all_characters/bloc/list_all_characters_state.dart';
import 'package:for_test/feature/list_all_characters/use_case_list_all_characters/get_all_persons_from_search_use_case.dart';
import 'package:for_test/feature/list_all_characters/use_case_list_all_characters/get_all_persons_use_case.dart';

class ListAllCharactersBloc extends Cubit<ListAllCharactersState> {
  ListAllCharactersBloc() : super(ShowLoadingMain()) {
    init();
    data.scrollController.addListener(() {
      if (data.scrollController.position.atEdge) {
        if (data.scrollController.position.pixels != 0) {
          getMorePersons();
        }
      }
    });
  }

  final GetAllPersonsUseCase getAllPersonsUseCase =
      locator.get<GetAllPersonsUseCase>();
  final GetAllPersonsFromSearchUseCase getAllPersonsFromSearchUseCase =
      locator.get<GetAllPersonsFromSearchUseCase>();
  DataListAllCharacters data = DataListAllCharacters();

  ListAllCharactersState get lastState  {
    if(state is ShowListPersons){
      return ShowListPersons(data: data);
    } else if(state is ShowListPersonsFromSearch){
      return ShowListPersonsFromSearch(data: data);
    } else {
      return Error(state.props.first.toString());
    }
  }

  void onChanges(String value) {
    if (state is ShowLoadingMain ||
        data.isLoadingListPersonsFromSearch ||
        data.isLoadingListPersons) {
      return;
    } else if (data.controller.text.isEmpty &&
        !data.isLoadingListPersonsFromSearch) {
      emit(ShowListPersons(data: data));
      return;
    } else {
      emit(lastState);
    }
  }

  Future<void> getSearchList() async {
    if (data.controller.text.isEmpty || data.isLoadingListPersonsFromSearch) {
      return;
    }
    data.isLoadingListPersonsFromSearch = true;
    data.listPersonsFromSearch.clear();
    emit(ShowListPersonsFromSearch(data: data));
    var result = await getAllPersonsFromSearchUseCase
        .call(GetAllPersonsFromSearchParams(data.controller.text));
    result.fold((l) {
      data.isLoadingListPersonsFromSearch = false;
      emit(Error(l.toString()));
      MsgToastUtil.showSnackBar(l.toString());
    }, (r) {
      data.isLoadingListPersonsFromSearch = false;
      data.listPersonsFromSearch = r;
      emit(ShowListPersonsFromSearch(data: data));
    });
  }

  void onClearTap() {
    if (state is ShowLoadingMain) {
      return;
    }
    data.listPersonsFromSearch.clear();
    data.controller.clear();
    emit(ShowListPersons(data: data));
  }

  Future<void> getMorePersons() async {
    if (data.isLoadingListPersons) {
      return;
    }
    data.isLoadingListPersons = true;
    emit(ShowListPersons(data: data));
    data.page = data.page + 10;// you can add 1 page
    var result =
        await getAllPersonsUseCase.call(GetAllPersonsParams(page: data.page));
    result.fold((l) {
      data.isLoadingListPersons = false;
      emit(ShowListPersons(data: data));
      MsgToastUtil.showSnackBar(l.toString());
    }, (r) {
      data.isLoadingListPersons = false;
      data.listPersons.addAll(r);
      emit(ShowListPersons(data: data));
    });
  }

  Future<void> init() async {
    data.page = 0;
    var result =
        await getAllPersonsUseCase.call(GetAllPersonsParams(page: data.page));
    result.fold((l) => emit(Error(l.toString())), (r) {
      data.listPersons = r;
      emit(ShowListPersons(data: data));
    });
  }

  @override
  Future<void> close() {
    data.controller.dispose();
    data.scrollController.dispose();
    return super.close();
  }
}

class DataListAllCharacters {
  int page = 0;
  ScrollController scrollController = ScrollController();
  List<PersonModel?> listPersons = [];
  List<PersonModel?> listPersonsFromSearch = [];
  bool isLoadingListPersons = false;
  bool isLoadingListPersonsFromSearch = false;
  bool showDeleteIcon = false;
  TextEditingController controller = TextEditingController();
}
