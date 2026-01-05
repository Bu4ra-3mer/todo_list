import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/features/todo_list/data/model/string_item_model.dart';
import 'package:todo_list/features/todo_list/domain/repository/string_item_repo.dart';
import 'package:todo_list/features/todo_list/presentation/cubit/cubit_state.dart';

@injectable
class StringItemCubit extends Cubit<StringItemState> {
  final StringItemRepo repository;

  StringItemCubit({required this.repository})
    : super(const StringItemState.initial());

  Future<void> fetchStringItems() async {
    emit(const StringItemState.loading());
    final result = await repository.getStrings();
    result.fold(
      (failure) =>
          emit(const StringItemState.failure(message: 'failed to fetch item')),
      (items) => emit(StringItemState.loaded(items: items)),
    );
  }

  Future<void> addString(String value) async {
    emit(const StringItemState.loading());
    final result = await repository.addStringItem(
      StringItemModel(value: value),
    );
    result.fold(
      (failure) =>
          emit(const StringItemState.failure(message: 'failed to add item')),
      (item) async {
        await fetchStringItems();
      },
    );
  }Future<void> deleteString(StringItemModel item) async {
  emit(const StringItemState.loading());
  final result = await repository.deleteStringItem(item.id); 
  result.fold(
    (failure) => emit(const StringItemState.failure(message: 'Failed to delete item')),
    (_) async {
      await fetchStringItems(); 
    },
  );
}



  void clearItems() {
      emit(const StringItemState.loaded(items: []));
  }
  
}
