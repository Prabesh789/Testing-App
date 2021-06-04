import 'package:flutter/material.dart';
import 'package:testapp/database_helper/sqflite_database.dart';
import 'package:testapp/screens/task_page.dart';
import 'package:testapp/widget/no_glow.dart';
import 'package:testapp/widget/task_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF6F6F6),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskPage(
                                        task: snapshot.data[index],
                                      ),
                                    ),
                                  );
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data[index].title,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 20.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskPage(task: null)),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 1.0),
                          colors: [
                            Color(0xFF7349FE),
                            Color(0xFF643FD8),
                          ],
                        )
                        // color: Color(0xFF7349FE),
                        ),
                    child: Image(
                      image: AssetImage('assets/images/add_icon.png'),
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
