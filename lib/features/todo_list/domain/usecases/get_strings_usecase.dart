import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/errors/failurs.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo_list/data/model/string_item_model.dart';
import 'package:todo_list/features/todo_list/domain/repository/string_item_repo.dart';

@injectable
class GetStringsUsecase extends Usecase<List<StringItemModel>, NoParams> {
  final StringItemRepo repository;
  GetStringsUsecase({required this.repository});
  @override
  Future<Either<Failure, List<StringItemModel>>> call(NoParams params) async {
    return await repository.getStrings();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
