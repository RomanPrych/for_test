import 'dart:convert';

import 'package:for_test/common/constants.dart';
import 'package:for_test/data/get_person/get_person_repo.dart';
import 'package:for_test/data/models/person_model.dart';
import 'package:http/http.dart' as http;

class GetPersonRepoImpl implements GetPersonRepo {
  GetPersonRepoImpl(this.client);

  final http.Client client;

  @override
  Future<({PersonModel? person, String? error})> getPerson(int? id) async {
    String url = baseUrl;
    PersonModel? personReturned;
    if (id == null) {
      return (person: null, error: 'Error id is null');
    }
    try {
      url = "$url/$id";
      final response = await client
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
      final person = json.decode(response.body);
      if (response.statusCode == 200) {
        personReturned = PersonModel.fromJson(person);
        return (person: personReturned, error: '');
      } else if (response.statusCode == 404) {
        return (person: null, error: '${person['error']}');
      } else {
        return (person: null, error: 'Error id is null');
      }
    } catch (e) {
      return (person: null, error: 'Error: $e');
    }
  }
}
