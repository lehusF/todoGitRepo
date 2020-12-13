import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todov1/models/task_model.dart';
import 'package:todov1/providers/tasks_provider.dart';

class TaskScreen extends StatefulWidget {
  static const routePath = '/task';

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime _pickedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  var _text = '';

  void _tryValidate(){
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(_isValid){
      _formKey.currentState.save();
      Provider.of<TasksProvider>(context, listen: false).addTask(new TaskModel(text: _text, dateTime: _pickedDate.toIso8601String(), isDone: 0));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _task = new TaskModel(dateTime: DateTime.now().toIso8601String(), text: 'Task1');
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление новой задачи'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: _formKey,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Дата задачи: ', style: TextStyle(fontSize: 22),),
                        InkWell(child: Text(DateFormat('dd.MM.yyyy').format(DateTime.now()), style: TextStyle(fontSize: 22),),
                            onTap: () async {
                              _pickedDate = await DatePicker.showSimpleDatePicker(
                                context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                                dateFormat: "dd-MMMM-yyyy",
                                locale: DateTimePickerLocale.ru,
                                looping: true,
                              );
                            }
                        ),
                      ],
                ),
                SizedBox(height: 20,),
                TextFormField(
                  autofocus: true,
                  validator: (value) => value.isEmpty ? 'Нужно заполнить' : null,
                  onSaved: (value) => _text = value,
                  decoration: InputDecoration(
                      labelText: 'Введите текст задачи'
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                SizedBox(height: 20,),
                RaisedButton.icon(
                  onPressed: _tryValidate,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  icon: Icon(Icons.save),
                  label: Text('Добавить'),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
