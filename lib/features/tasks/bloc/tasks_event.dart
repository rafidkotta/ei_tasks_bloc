part of 'tasks_bloc.dart';

class TasksEvent {}

class TasksInit extends TasksEvent{}

class TaskAdd extends TasksEvent{
  final Task task;
  TaskAdd({required this.task});
}

class TaskRemove extends TasksEvent{
  final Task task;
  TaskRemove({required this.task});
}

