import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/features/todo_list/data/model/string_item_model.dart';

part 'cubit_state.freezed.dart';

@freezed
class StringItemState with _$StringItemState {
  const factory StringItemState.initial() = _Initial;
  const factory StringItemState.loading() = _Loading;
  const factory StringItemState.loaded({required List<StringItemModel> items}) = _Loaded;
  const factory StringItemState.failure({required String message}) = _Failure;
  
}