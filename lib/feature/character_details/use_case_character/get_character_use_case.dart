import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:for_test/common/di.dart';
import 'package:for_test/common/usecase/errors.dart';
import 'package:for_test/common/usecase/usecase.dart';
import 'package:for_test/data/get_person/get_person_repo.dart';
import 'package:for_test/data/models/person_model.dart';

class GetCharacterUseCase implements UseCase<PersonModel?, GetPersonParams> {
  final GetPersonRepo getPersonRepo = locator.get<GetPersonRepo>();

  @override
  Future<Either<Failure, PersonModel?>> call(GetPersonParams params) async {
    ({PersonModel? person, String? error}) result =
        await getPersonRepo.getPerson(params.id);
    if (result.person == null) {
      return left(ErrorGetList(result.error));
    } else {
      return right(result.person);
    }
  }
}

class GetPersonParams extends Equatable {
  const GetPersonParams(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
