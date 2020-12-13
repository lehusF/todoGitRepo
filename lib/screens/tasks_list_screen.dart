import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks_provider.dart';
import '../widgets/navbar_item_widget.dart';
import 'active_tasks_screen.dart';
import 'all_tasks_screen.dart';
import 'done_tasks_screen.dart';
import 'task_screen.dart';

class TasksListScreen extends StatefulWidget {
  static const routePath = '/tasks-list';

  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  final List<Widget> _pages = [TaskListBodyWidget(), ActiveTasksScreen(), DoneTasksScreen()];
  final List<String> _titles = ['Все задачи', 'Активные задачи', 'Выполненные задачи'];

  var _bottomPageCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var _allCount = Provider.of<TasksProvider>(context).allTasks.length;
    var _activeCount = Provider.of<TasksProvider>(context, listen: false).activeTasks.length;
    var _doneCount = Provider.of<TasksProvider>(context, listen: false).doneTasks.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_bottomPageCurrentIndex]),
      ),
      body: _pages[_bottomPageCurrentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, TaskScreen.routePath);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomPageCurrentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _bottomPageCurrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: NavbarItemWidget(icon: Icons.list, count: _allCount,),
              label: 'Все'
          ),
          BottomNavigationBarItem(
              icon: NavbarItemWidget(icon: Icons.card_travel, count: _activeCount,),
              label: 'В ожидании'
          ),
          BottomNavigationBarItem(
              icon: NavbarItemWidget(icon: Icons.done_all, count: _doneCount,),
              label: 'Выполненные'
          ),
        ],
      ),
    );
  }
}

