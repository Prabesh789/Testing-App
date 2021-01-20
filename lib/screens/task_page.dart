import 'package:flutter/material.dart';
import 'package:testapp/Model/task.dart';
import 'package:testapp/database_helper/sqflite_database.dart';
import 'package:testapp/widget/todo_task.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
                              if (value != '') {
                                DatabaseHelper _dbHelper = DatabaseHelper();
                                Task _newTask = Task(title: value);
                                await _dbHelper.insertTask(_newTask);

                                print('New Task has been created');
                              }
                            },
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
                      decoration: InputDecoration(hintText: 'Enter Task Title'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TodoTask(
                    text: "Create Your Fisrt Task",
                    isDone: true,
                  ),
                  TodoTask(
                    text: "Create Your First Todo",
                    isDone: false,
                  ),
                  TodoTask(
                    text: 'Just another Todo',
                    isDone: false,
                  ),
                  TodoTask(
                    isDone: true,
                  ),
                ],
              ),
              Positioned(
                bottom: 20.0,
                right: 12.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TaskPage()));
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
