import 'package:ei_taks/features/tasks/bloc/tasks_bloc.dart';
import 'package:ei_taks/features/tasks/view/add_task.dart';
import 'package:ei_taks/features/tasks/widget/task_item.dart';
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
    context.read<TasksBloc>().add(TaskLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog<bool>(context: context, builder: (ctx){
                return AlertDialog(
                  icon: const Icon(Icons.delete_sweep,size: 48,),
                  content: const Text("Clear all the existing tasks ?",textAlign: TextAlign.center,),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Yes")),
                    TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("No"))
                  ],
                );
              }).then((value){
                if(value == null){
                  return;
                }
                if(value){
                  context.read<TasksBloc>().add(TaskClear());
                }
              });
            },
            tooltip: "Clear tasks",
            icon: const Icon(Icons.delete_sweep),
          )
        ],
      ),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if(state.status == TasksStatus.failure){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Problem loading tasks"),
                  const SizedBox(height: 10,),
                  OutlinedButton(
                    onPressed: (){
                      context.read<TasksBloc>().add(TaskLoad());
                    },
                    child: const Text("Retry"),
                  )
                ],
              ),
            );
          }
          if(state.status == TasksStatus.loading || state.status == TasksStatus.unknown){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state.status == TasksStatus.loaded){
            if(state.tasks.isEmpty){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.task),
                    const SizedBox(height: 10,),
                    const Text("No tasks to view"),
                    const SizedBox(height: 10,),
                    OutlinedButton(
                      onPressed: () => addTask(context),
                      child: const Text("Add new"),
                    )
                  ],
                ),
              );
            }
            return ListView(
              children: List.generate(state.tasks.length, (index){
                return TaskItem(
                  task: state.tasks.elementAt(index),
                  onDelete: (){
                    context.read<TasksBloc>().add(TaskRemove(task: state.tasks.elementAt(index)));
                  },
                );
              }),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addTask(context),
        label: const Icon(Icons.add),
        icon: const Text("Add task"),
      ),
    );
  }

  addTask(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => BlocProvider.value(
        value: BlocProvider.of<TasksBloc>(context), child: const AddTask(),
      ),
    ),);
  }
}