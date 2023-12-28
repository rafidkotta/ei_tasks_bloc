import 'package:ei_taks/features/tasks/bloc/tasks_bloc.dart';
import 'package:ei_taks/features/tasks/view/add_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if(state.status == TasksStatus.loading || state.status == TasksStatus.unknown){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state.status == TasksStatus.loaded){
            return ListView(
              children: List.generate(state.tasks.length, (index){
                final task = state.tasks.elementAt(index);
                return Card(
                  child: Column(
                    children: [
                      Text(task.title),
                      Text(task.description),
                      Text(task.assignedTo),
                    ],
                  ),
                );
              }),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>
              BlocProvider.value(value: BlocProvider.of<TasksBloc>(context),
                  child: const AddTask())),);
        },
        label: const Icon(Icons.add),
        icon: const Text("Add task"),
      ),
    );
  }
}