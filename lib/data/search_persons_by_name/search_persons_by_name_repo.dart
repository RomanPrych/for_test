import 'package:for_test/data/models/person_model.dart';

abstract class SearchPersonsByNameRepo {
  Future <({List<PersonModel?> listPersons, String? error})> getListSearch(String searchText);

}