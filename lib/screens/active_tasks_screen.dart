
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todov1/providers/tasks_provider.dart';
import 'package:todov1/widgets/task_item_widget.dart';

class ActiveTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: Provider.of<TasksProvider>(context, listen: false).getTasks(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator(),) :
        RefreshIndicator(
          onRefresh: () => Provider.of<TasksProvider>(context, listen: false).getTasks(),
          child: Consumer<TasksProvider>(
            child: Center(child: const Text('Задач пока нет')),
            builder: (ctx, data, child) => data.activeTasks.length <= 0 ? child : ListView.builder(
              itemBuilder: (ctx, i) => TaskItemWidget(
                id: data.activeTasks[i].id,
                text: data.activeTasks[i].text,
                dateTime: DateFormat('dd.MM.yyyy').format(DateTime.parse(data.activeTasks[i].dateTime)),
                isDone: data.activeTasks[i].isDone,
              ),
              itemCount: data.activeTasks.length,
            ),),
        ),
      ),
    );
  }
}
