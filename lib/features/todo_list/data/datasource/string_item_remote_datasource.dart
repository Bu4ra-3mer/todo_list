import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:todo_list/core/errors/exception.dart';
import 'package:todo_list/features/todo_list/data/model/string_item_model.dart';

abstract class StringItemRemoteDatasource {
  Future<List<StringItemModel>> getStringItems();
  Future<void> addStringItem(StringItemModel item);
}

@Injectable(as: StringItemRemoteDatasource)
class StringItemRemoteDatasourceImpl implements StringItemRemoteDatasource {
  StringItemRemoteDatasourceImpl();
  @override
  Future<List<StringItemModel>> getStringItems() async {
    final QueryBuilder<StringItemModel> query = QueryBuilder<StringItemModel>(
      StringItemModel.clone(),
    );
    final ParseResponse response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<StringItemModel>();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> addStringItem(StringItemModel item) async {
    final ParseResponse response = await item.save();
    
    if (response.success) {
      print('Item added successfully');
    } else {
      throw ServerException();
    }
  }
}
