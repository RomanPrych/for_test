import 'package:for_test/data/models/person_model.dart';

abstract class GetAllPersonsListByPageRepo {
   Future <({List <PersonModel?> listPersons,String? error})> getList({int? page});
}