import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/errors/exception.dart';
import 'package:todo_list/core/errors/failurs.dart';
import 'package:todo_list/features/todo_list/data/datasource/string_item_remote_datasource.dart';
import 'package:todo_list/features/todo_list/data/model/string_item_model.dart';
import 'package:todo_list/features/todo_list/domain/repository/string_item_repo.dart';


@Injectable(as: StringItemRepo)
class StringItemRepoImpl implements  StringItemRepo {
  StringItemRemoteDatasource remote;

  StringItemRepoImpl({required this.remote});

  @override
  Future<Either<Failure, StringItemModel>> addStringItem(
    StringItemModel item,
  ) async {
    try {
      await remote.addStringItem(item);
      return Right(item);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<StringItemModel>>> getStrings() async{
    try {
      final items=await remote.getStringItems();
      return Right(items);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteStringItem(String id)async {
    try {
      final item = StringItemModel.clone()..objectId = id;
      await item.delete(); 
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
