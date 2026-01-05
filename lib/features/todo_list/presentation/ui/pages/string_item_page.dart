import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:todo_list/features/todo_list/presentation/ui/widgets/alert_dialog.dart';
import 'package:todo_list/features/todo_list/presentation/ui/widgets/task_header.dart';
import 'package:todo_list/features/todo_list/presentation/ui/widgets/tasks_app_bar.dart';
import 'package:todo_list/features/todo_list/presentation/ui/widgets/tasks_list.dart';
import 'package:todo_list/features/todo_list/presentation/ui/widgets/wlcome_card.dart';

@RoutePage()
class StringItemPage extends StatelessWidget {
  const StringItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar:const TasksAppBar(),
      body: BlocConsumer<AuthCubitCubit, AuthCubitState>(
        listener: (context, state) {
          state.maybeWhen(
            signOutSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Signed out successfully")),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, authState) {
          final authCubit = context.watch<AuthCubitCubit>();
          final userName =
              (authCubit.currentUser?.isAnonymous == true)
                  ? "Guest"
                  : (authCubit.currentUser?.userName ?? "User");
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Card
                WelcomCard(userName: userName),

                const SizedBox(height: 24),

                // Tasks Header
                TasksHeader(),

                const SizedBox(height: 8),

                // Tasks List
                Expanded(
                  child: TasksList(),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddItemDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AddTaskDialog(controller: controller),
    );
  }
}
