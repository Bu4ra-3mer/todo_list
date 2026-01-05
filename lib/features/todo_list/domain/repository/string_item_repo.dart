import 'package:dartz/dartz.dart';
import 'package:todo_list/core/errors/failurs.dart';
import 'package:todo_list/features/todo_list/data/model/string_item_model.dart';


abstract class StringItemRepo {
  Future<Either<Failure,StringItemModel>> addStringItem(StringItemModel item);
  Future<Either<Failure,List<StringItemModel>>> getStrings();
  Future<Either<Failure, void>> deleteStringItem(String id);

}
