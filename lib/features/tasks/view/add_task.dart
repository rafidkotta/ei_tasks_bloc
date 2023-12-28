import 'package:ei_taks/features/tasks/bloc/tasks_bloc.dart';
import 'package:ei_taks/features/tasks/model/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortid/shortid.dart';

class AddTask extends StatefulWidget{
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final List<String> employees = ['Amar','Akbar','Antony'];

  String? selectedEmployee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add task"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          if(formKey.currentState!.validate()){
            final task =  Task(id: shortid.generate(), title: titleController.text, description: descriptionController.text, assignedTo: "");
            context.read<TasksBloc>().add(TaskAdd(task: task));
            Navigator.of(context).pop();
          }
        },
        label: const Icon(Icons.check),
        icon: const Text("Submit"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder()
                ),
                validator: (text){
                  if(text == null){
                    return "Invalid title";
                  }else if(text.length < 3){
                    return "Invalid title";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8,),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder()
                ),
                validator: (text){
                  if(text == null){
                    return "Invalid description";
                  }else if(text.length < 3){
                    return "Invalid description";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8,),
              DropdownButtonFormField<String>(
                value: selectedEmployee,
                validator: (employee){
                  if(employee == null){
                    return "Choose an employee";
                  }
                  return null;
                },
                items: employees.map((employee) => DropdownMenuItem(value: employee,child: Text(employee),)).toList(),
                onChanged: (item){
                  setState(() {
                    selectedEmployee = item;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Assigned employee",
                  border: OutlineInputBorder()
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}