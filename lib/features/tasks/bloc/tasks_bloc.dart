import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ei_taks/helper/db_helper.dart';

import '../model/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState()) {
    on<TaskLoad>(_handleTaskLoad);
    on<TaskAdd>(_handleTaskAdd);
    on<TaskRemove>(_handleTaskRemove);
    on<TaskClear>(_handleTaskClear);
  }

  Future<void> _handleTaskLoad(TaskLoad event, Emitter<TasksState> emit) async {
    emit(state.copyWith(status: TasksStatus.loading));
    final tasks = await DatabaseHelper.instance.listTasks();
    emit(state.copyWith(tasks: tasks.toSet(),status: TasksStatus.loaded));
  }

  Future<void> _handleTaskAdd(TaskAdd event, Emitter<TasksState> emit) async {
    await DatabaseHelper.instance.addTask(event.task);
    emit(state.copyWith(tasks: {...state.tasks,event.task}));
  }

  Future<void> _handleTaskRemove(TaskRemove event, Emitter<TasksState> emit) async {
    await DatabaseHelper.instance.deleteTask(event.task);
    emit(state.copyWith(tasks: {...state.tasks}..remove(event.task)));
  }
  Future<void> _handleTaskClear(TaskClear event, Emitter<TasksState> emit) async {
    await DatabaseHelper.instance.clearTasks();
    emit(state.copyWith(tasks: {...state.tasks}..clear()));
  }
}


