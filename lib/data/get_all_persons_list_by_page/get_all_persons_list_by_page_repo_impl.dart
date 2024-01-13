import 'dart:convert';

import 'package:for_test/common/constants.dart';
import 'package:for_test/data/get_all_persons_list_by_page/get_all_persons_list_by_page_repo.dart';
import 'package:for_test/data/models/person_model.dart';
import 'package:http/http.dart' as http;

class GetAllPersonsListByPageRepoImpl implements GetAllPersonsListByPageRepo {
  GetAllPersonsListByPageRepoImpl(this.client);

  final http.Client client;

  @override
  Future<({List<PersonModel?> listPersons, String? error})> getList(
      {int? page}) async {
    String url = baseUrl;
    List<PersonModel?> returnedListPersons = [];
    if (page != null) {
      url = "$url/?page=$page";
    }
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
