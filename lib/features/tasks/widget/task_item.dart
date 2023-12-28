import 'package:ei_taks/features/tasks/model/task.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget{
  final Task task;
  final Function()? onDelete;
  const TaskItem({super.key, required this.task, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Text(task.description,maxLines: 3,),
                  Row(
                    children: [
                      const Icon(Icons.account_circle),
                      const SizedBox(width: 8,),
                      Text(task.assignedTo),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(onPressed: (){
              if(onDelete != null){
                showDialog<bool>(context: context, builder: (ctx){
                  return AlertDialog(
                    icon: const Icon(Icons.delete,size: 48,),
                    content: const Text("Remove task ?",textAlign: TextAlign.center,),
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
                    onDelete!();
                  }
                });

              }
            }, icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }

}