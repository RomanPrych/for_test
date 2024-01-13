import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:for_test/common/di.dart';
import 'package:for_test/common/usecase/errors.dart';
import 'package:for_test/common/usecase/usecase.dart';
import 'package:for_test/data/get_all_persons_list_by_page/get_all_persons_list_by_page_repo.dart';
import 'package:for_test/data/models/person_model.dart';

class GetAllPersonsUseCase
    implements UseCase<List<PersonModel?>, GetAllPersonsParams> {
  final GetAllPersonsListByPageRepo getAllPersonsListByPageRepo =
      locator.get<GetAllPersonsListByPageRepo>();

  @override
  Future<Either<Failure, List<PersonModel?>>> call(
      GetAllPersonsParams params) async {
    ({List<PersonModel?> listPersons, String? error}) result =
        await getAllPersonsListByPageRepo.getList(page: params.page);
    if (result.listPersons.isEmpty) {
      return left(ErrorGetList(result.error));
    } else {
      return right(result.listPersons);
    }
  }
}

class GetAllPersonsParams extends Equatable {
  const GetAllPersonsParams({this.page});

  final int? page;

  @override
  List<Object?> get props => [page];
}
