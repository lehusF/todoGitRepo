import 'package:flutter/cupertino.dart';
import 'package:todov1/helpers/db_helper.dart';
import 'package:todov1/models/task_model.dart';
import 'package:uuid/uuid.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> _items = [];
  List<TaskModel> get allTasks {
    _items.sort((a, b) => DateTime.parse(a.dateTime).compareTo(DateTime.parse(b.dateTime)));
    return  [..._items];
  }

  List<TaskModel> get activeTasks {
    var _filtred = _items.where((element) => element.isDone == 0).toList();
    _filtred.sort((a, b) => DateTime.parse(a.dateTime).compareTo(DateTime.parse(b.dateTime)));
    return  [..._filtred];
  }

  List<TaskModel> get doneTasks {
    var _filtred = _items.where((element) => element.isDone == 1).toList();
    _filtred.sort((a, b) => DateTime.parse(a.dateTime).compareTo(DateTime.parse(b.dateTime)));
    return  [..._filtred];
  }

  var uuid = Uuid();

  void addTask(TaskModel task) {
    var id = uuid.v1();
    task.id = id;
    _items.add(task);
    notifyListeners();
    DbHelper.insert('tasks', {
      'id': id,
      'text': task.text,
      'dateTime': task.dateTime,
      'isDone' : 0
    });
  }

  Future<void> getTasks() async {
     var tasks = await DbHelper.get('tasks');
    _items = tasks
        .map((e) => new TaskModel(
        id: e['id'],
        text: e['text'],
        dateTime: e['dateTime'],
        isDone: e['isDone']
    )).toList();

    notifyListeners();
  }

  Future<void> updateTaskState(String id, int isDone)async{
    _items.firstWhere((element) => element.id == id).isDone = isDone;
    await DbHelper.updateTaskState(id, isDone);
    notifyListeners();
  }

  Future<void> removeTask(String id) async{
    _items.removeWhere((element) => element.id == id);
    await DbHelper.removeTask(id);
    notifyListeners();
  }
}