import 'dart:async';

import 'package:bloc/bloc.dart';

import '../model/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState()) {
    on<TasksInit>(_handleTaskLoad);
    on<TaskAdd>(_handleTaskAdd);
    on<TaskRemove>(_handleTaskRemove);
  }

  Future<void> _handleTaskLoad(TasksInit event, Emitter<TasksState> emit) async {

  }

  Future<void> _handleTaskAdd(TaskAdd event, Emitter<TasksState> emit) async {
    emit(state.copyWith(tasks: {...state.tasks,event.task}));
  }

  Future<void> _handleTaskRemove(TaskRemove event, Emitter<TasksState> emit) async {
    emit(state.copyWith(tasks: {...state.tasks}..remove(event.task)));
  }

}


