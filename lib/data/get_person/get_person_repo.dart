import 'package:for_test/data/models/person_model.dart';

abstract class GetPersonRepo {
  Future <({PersonModel? person, String? error})> getPerson(int? id);
}