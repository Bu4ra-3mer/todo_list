import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo_list/presentation/cubit/cubit_cubit.dart';
import 'package:todo_list/features/todo_list/presentation/cubit/cubit_state.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StringItemCubit, StringItemState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: state.when(
            initial:
                () => const Center(child: Text('No Tasks yet!')),
            loading:
                () => const Center(
                  child: CircularProgressIndicator(),
                ),
            loaded:
                (items) => ListView.separated(
                  itemCount: items.length,
                  separatorBuilder:
                      (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Dismissible(
                      key: Key(item.id),
                      background: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        alignment: Alignment.centerLeft,
                        color: Colors.redAccent,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.startToEnd,
                      onDismissed:
                          (_) => context
                              .read<StringItemCubit>()
                              .deleteString(item),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(item.value),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                            onPressed:
                                () => context
                                    .read<StringItemCubit>()
                                    .deleteString(item),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            failure:
                (message) =>
                    Center(child: Text("Error: $message")),
          ),
        );
      },
    );
  }
}