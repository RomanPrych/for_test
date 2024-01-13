import 'package:for_test/data/get_all_persons_list_by_page/get_all_persons_list_by_page_repo.dart';
import 'package:for_test/data/get_all_persons_list_by_page/get_all_persons_list_by_page_repo_impl.dart';
import 'package:for_test/data/get_person/get_person_repo.dart';
import 'package:for_test/data/get_person/get_person_repo_impl.dart';
import 'package:for_test/data/search_persons_by_name/search_persons_by_name_repo.dart';
import 'package:for_test/data/search_persons_by_name/search_persons_by_name_repo_impl.dart';
import 'package:for_test/data/shared_preferences/shared_preference.dart';
import 'package:for_test/data/shared_preferences/shared_preferences_impl.dart';
import 'package:for_test/feature/character_details/use_case_character/get_character_use_case.dart';
import 'package:for_test/feature/list_all_characters/use_case_list_all_characters/get_all_persons_from_search_use_case.dart';
import 'package:for_test/feature/list_all_characters/use_case_list_all_characters/get_all_persons_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => http.Client());

  locator.registerLazySingleton<SharedPreference>(
      () => SharedPreferenceImpl(prefs));
  locator.registerLazySingleton<GetAllPersonsListByPageRepo>(
      () => GetAllPersonsListByPageRepoImpl(locator.get<http.Client>()));
  locator.registerLazySingleton<GetPersonRepo>(
      () => GetPersonRepoImpl(locator.get<http.Client>()));
  locator.registerLazySingleton<SearchPersonsByNameRepo>(
      () => SearchPersonsByNameRepoImpl(locator.get<http.Client>()));
  locator.registerLazySingleton<GetAllPersonsUseCase>(
      () => GetAllPersonsUseCase());
  locator.registerLazySingleton<GetAllPersonsFromSearchUseCase>(
      () => GetAllPersonsFromSearchUseCase());
  locator.registerLazySingleton<GetCharacterUseCase>(
      () => GetCharacterUseCase());
}
