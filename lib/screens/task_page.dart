import 'package:flutter/material.dart';
import 'package:testapp/Model/task.dart';
import 'package:testapp/Model/todo.dart';
import 'package:testapp/database_helper/sqflite_database.dart';
import 'package:testapp/widget/todo_task.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({Key key, @required this.task}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String _taskTitle = '';

  @override
  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: TextField(
                            onSubmitted: (value) async {
                              //Check if the task is not empty
                              if (value != '') {
                                //check if the task is null
                                if (widget.task == null) {
                                  DatabaseHelper _dbHelper = DatabaseHelper();
                                  Task _newTask = Task(title: value);
                                  await _dbHelper.insertTask(_newTask);
                                  //print('New Task has been created');
                                } else {
                                  // print('Update the existing task');
                                }
                              }
                            },
                            controller: TextEditingController()
                              ..text = _taskTitle,
                            decoration:
                                InputDecoration(hintText: 'Enter Task Title'),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: 'Enter description'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 12),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF86829D),
                                  width: 1.5,
                                ),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/check_icon.png',
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                onSubmitted: (value) async {
                                  if (value != '') {
                                    //check if the task is null
                                    if (widget.task != null) {
                                      DatabaseHelper _dbHelper =
                                          DatabaseHelper();
                                      Todo _newTodo = Todo(
                                        title: value,
                                        isDone: 0,
                                        taskId: widget.task.id,
                                      );
                                      await _dbHelper.insertTodo(_newTodo);
                                      print('New Task has been created');
                                    } else {
                                      print('Task Does not exist');
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter Todo item..',
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  // TodoTask(
                  //   text: "Create Your First Todo",
                  //   isDone: false,
                  // ),
                  // TodoTask(
                  //   text: 'Just another Todo',
                  //   isDone: false,
                  // ),
                  // TodoTask(
                  //   isDone: true,
                  // ),
                ],
              ),
              Positioned(
                bottom: 20.0,
                right: 12.0,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => TaskPage()));
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFFE3577),
                    ),
                    child: Image(
                      image: AssetImage('assets/images/delete_icon.png'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
