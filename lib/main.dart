import 'package:ei_taks/features/tasks/bloc/tasks_bloc.dart';
import 'package:ei_taks/features/tasks/view/tasks.dart';
import 'package:ei_taks/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<TasksBloc>(
        create: (context) => TasksBloc(),
        child: const Tasks(),
      ),
    );
  }
}
