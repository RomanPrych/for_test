import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:for_test/common/di.dart';
import 'package:for_test/common/usecase/errors.dart';
import 'package:for_test/common/usecase/usecase.dart';
import 'package:for_test/data/models/person_model.dart';
import 'package:for_test/data/search_persons_by_name/search_persons_by_name_repo.dart';

class GetAllPersonsFromSearchUseCase
    implements UseCase<List<PersonModel?>, GetAllPersonsFromSearchParams> {
final SearchPersonsByNameRepo searchPersonsByNameRepo = locator.get<SearchPersonsByNameRepo>();


  @override
  Future<Either<Failure, List<PersonModel?>>> call(
      GetAllPersonsFromSearchParams params) async {
    ({List<PersonModel?> listPersons, String? error}) result =
    await searchPersonsByNameRepo.getListSearch(params.searchText);
    if (result.listPersons.isEmpty) {
      return left(ErrorGetList(result.error));
    } else {
      return right(result.listPersons);
    }
  }
}

class GetAllPersonsFromSearchParams extends Equatable {
  const GetAllPersonsFromSearchParams(this.searchText);

  final String searchText;

  @override
  List<Object?> get props => [searchText];
}
