import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties = const <dynamic>[];

  const Failure([properties]);

  @override
  List<Object> get props => [properties];
}

class ErrorGetList extends Failure {
  const ErrorGetList([this.error]);
  final String? error;
@override
  String toString() {
    return error ?? super.toString();
  }

}
