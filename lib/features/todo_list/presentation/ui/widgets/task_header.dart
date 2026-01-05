
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo_list/presentation/cubit/cubit_cubit.dart';

class TasksHeader extends StatelessWidget {
  const TasksHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Your Tasks',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed:
              () =>
                  context
                      .read<StringItemCubit>()
                      .fetchStringItems(),
        ),
      ],
    );
  }
}
