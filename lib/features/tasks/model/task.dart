import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String id;
  final String title;
  final String description;
  final String assignedTo;
  const Task({required this.id, required this.title, required this.description, required this.assignedTo});

  @override
  List<Object?> get props => [id,title,description,assignedTo];
}