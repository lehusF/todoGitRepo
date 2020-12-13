import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todov1/providers/tasks_provider.dart';

class TaskItemWidget extends StatefulWidget {
  String id;
  String text;
  String dateTime;
  int isDone;
  TaskItemWidget({this.id, this.text, this.dateTime, this.isDone});

  @override
  _TaskItemWidgetState createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(40)
        ),
        //color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white,),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      ),
      onDismissed: (_){
        Provider.of<TasksProvider>(context, listen: false).removeTask(widget.id);
      },
      confirmDismiss: (dissmis){
        return showDialog(context: context, builder: (context) =>
            AlertDialog(
              title: Text('Подтвердите действие'),
              content: Text('Точно хотите удалить?'),
              actions: [
                FlatButton(child: Text('Нет'), onPressed: () => Navigator.of(context).pop(false),),
                FlatButton(child: Text('Да'), onPressed: () => Navigator.of(context).pop(true),),
              ],
            )
        );
      },
      child: Card(
        elevation: 5,
        shadowColor: Colors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: ListTile(
          title: Text(widget.text),
          subtitle: Text(widget.dateTime),
          trailing: Checkbox(
            value: widget.isDone == 0 ? false : true,
            onChanged: (newvalue) {
              setState(() {
                var tv = newvalue ? 1 : 0;
                widget.isDone = tv;
                Provider.of<TasksProvider>(context, listen: false).updateTaskState(widget.id, tv);
              });
            },
          ),
        ),
      ),
    );
  }
}
