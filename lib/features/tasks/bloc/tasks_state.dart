part of 'tasks_bloc.dart';

class TasksState {
  final TasksStatus status;
  final Set<Task> tasks;
  TasksState({this.tasks = const {}, this.status = TasksStatus.unknown});

  TasksState copyWith({
    TasksStatus? status,
    Set<Task>? tasks,
  }) => TasksState(
    tasks: tasks ?? this.tasks,
    status: status ?? this.status,
  );
}

enum TasksStatus{
  unknown,
  loading,
  loaded,
  failure
}
