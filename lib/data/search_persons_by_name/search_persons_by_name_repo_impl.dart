import 'dart:convert';

import 'package:for_test/common/constants.dart';
import 'package:for_test/data/models/person_model.dart';
import 'package:for_test/data/search_persons_by_name/search_persons_by_name_repo.dart';
import 'package:http/http.dart' as http;

class SearchPersonsByNameRepoImpl implements SearchPersonsByNameRepo {
  SearchPersonsByNameRepoImpl(this.client);

  final http.Client client;

  @override
  Future<({List<PersonModel?> listPersons, String? error})> getListSearch(
      String searchText) async {
    String url = baseUrl;
    List<PersonModel?> returnedListPersons = [];
    url = "$url/?name=$searchText";
    try {
      final response = await client
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
      final persons = json.decode(response.body);
      if (response.statusCode == 200) {
        returnedListPersons = (persons['results'] as List)
            .map((person) => PersonModel.fromJson(person))
            .toList();
        return (listPersons: returnedListPersons, error: '');
      } else if (response.statusCode == 404) {
        return (listPersons: returnedListPersons, error: '${persons['error']}');
      } else {
        return (listPersons: returnedListPersons, error: 'Fatal error');
      }
    } catch (e) {
      return (listPersons: returnedListPersons, error: 'Error: $e');
    }
  }
}
