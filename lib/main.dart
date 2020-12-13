import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todov1/providers/tasks_provider.dart';
import 'package:todov1/screens/task_screen.dart';
import 'package:todov1/screens/tasks_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TasksProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
           primarySwatch: Colors.blue,
           visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          TaskScreen.routePath : (ctx) => TaskScreen()
        },
        home: TasksListScreen(),
      ),
    );
  }
}

