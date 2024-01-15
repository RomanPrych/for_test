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
    //[init()] method starts first and get all data from free api
    init();
    data.scrollController.addListener(() {
      if (data.scrollController.position.atEdge) {
        if (data.scrollController.position.pixels != 0) {
          //here if user scroll to end of page, we get and add more persons to screen by using [getMorePersons()] method
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
    // Here we get last state that was send to page
    if(state is ShowListPersons){
      return ShowListPersons(data: data);
    } else if(state is ShowListPersonsFromSearch){
      return ShowListPersonsFromSearch(data: data);
    } else {
      return Error(state.props.first.toString());
    }
  }

  void onChanges(String value) {
    /*
      On text field changes we send last state to refresh close icon when text field is empty or not empty
     */
    if (state is ShowLoadingMain ||
        data.isLoadingListPersonsFromSearch ||
        data.isLoadingListPersons) {
      // if working one of searches we do not do anything
      return;
    } else if (data.controller.text.isEmpty &&
        !data.isLoadingListPersonsFromSearch) {
      //if user delete all search text from text field we show last results of main search
      emit(ShowListPersons(data: data));
      return;
    } else {
      //send last state to keep widgets on page but refresh close icon when text field is empty or not empty
      emit(lastState);
    }
  }

  Future<void> getSearchList() async {
    // find result of search text and display it
    if (data.controller.text.isEmpty || data.isLoadingListPersonsFromSearch) {
    // if the are not search text or search method is working we do anything
      return;
    }
    //show loading (last widget in the list)
    data.isLoadingListPersonsFromSearch = true;
    data.listPersonsFromSearch.clear();
    emit(ShowListPersonsFromSearch(data: data));
    //get search results
    var result = await getAllPersonsFromSearchUseCase
        .call(GetAllPersonsFromSearchParams(data.controller.text));
    result.fold((l) {
      //if the is error we show error and remove loading
      data.isLoadingListPersonsFromSearch = false;
      emit(Error(l.toString()));
      MsgToastUtil.showSnackBar(l.toString());
    }, (r) {
      //if we get results - remove loading and send results
      data.isLoadingListPersonsFromSearch = false;
      data.listPersonsFromSearch = r;
      emit(ShowListPersonsFromSearch(data: data));
    });
  }

  void onClearTap() {
    if (state is ShowLoadingMain) {
      // if working first main loading we do anything
      return;
    }
    //clear text in text field and clear list searches and show main list persons
    data.listPersonsFromSearch.clear();
    data.controller.clear();
    emit(ShowListPersons(data: data));
  }

  Future<void> getMorePersons() async {
    if (data.isLoadingListPersons) {
      //if method get persons main working we do anything
      return;
    }
    //show loading in list persons (last widget)
    data.isLoadingListPersons = true;
    emit(ShowListPersons(data: data));
    //add 10 pages to all pages
    data.page = data.page + 10;// you can add 1 page
    //get results by page
    var result =
        await getAllPersonsUseCase.call(GetAllPersonsParams(page: data.page));
    result.fold((l) {
      //if the is error we remove loading and show massage of error
      data.isLoadingListPersons = false;
      emit(ShowListPersons(data: data));
      MsgToastUtil.showSnackBar(l.toString());
    }, (r) {
      //if it is ok we remove loading and show persons ald + new that we get
      data.isLoadingListPersons = false;
      data.listPersons.addAll(r);
      emit(ShowListPersons(data: data));
    });
  }

  Future<void> init() async {
    //first method get first page persons and display on screen
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
  //data all page
  int page = 0;
  ScrollController scrollController = ScrollController();
  List<PersonModel?> listPersons = [];
  List<PersonModel?> listPersonsFromSearch = [];
  bool isLoadingListPersons = false;
  bool isLoadingListPersonsFromSearch = false;
  bool showDeleteIcon = false;
  TextEditingController controller = TextEditingController();
}
