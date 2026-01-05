import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/errors/failurs.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo_list/data/model/string_item_model.dart';
import 'package:todo_list/features/todo_list/domain/repository/string_item_repo.dart';

@injectable
class AddStringItemUsecase extends Usecase<void, AddStringItemParams> {
  final StringItemRepo repository;
  AddStringItemUsecase({required this.repository});

  @override
  Future<Either<Failure,void>>call(AddStringItemParams params) async {
    return await repository.addStringItem(StringItemModel(value: params.value));
  }
}


class AddStringItemParams extends Equatable {
  final String value;
  const AddStringItemParams({required this.value});
  @override
  List<Object?> get props => [value];
}
