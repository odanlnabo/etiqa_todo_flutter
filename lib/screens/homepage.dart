import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:etiqa_todo_flutter/models/todo_model.dart';
import 'package:etiqa_todo_flutter/screens/todo_page.dart';
import 'package:etiqa_todo_flutter/widgets/todo_card_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF59E0B),
        centerTitle: false,
        title: Text(
          'To-Do List',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<TodoModel>(
          builder: (context, todo, child) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildTodoList(todo),
                  _buildCreateButton(todo),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTodoList(todo) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: todo.doList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ChangeNotifierProvider<TodoModel>.value(
                        value: todo,
                        child: TodoPage(
                          doModel: todo.doList[index],
                        ),
                      );
                    }),
                  );
                },
                child: TodoCardWidget(
                  title: todo.doList[index].title,
                  startDate: todo.doList[index].startDate,
                  endDate: todo.doList[index].endDate,
                  completed: todo.doList[index].completed,
                  completeTask: () {
                    Provider.of<TodoModel>(context, listen: false).completeDo(
                      id: todo.doList[index].id,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton(todo) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChangeNotifierProvider<TodoModel>.value(
                  value: todo,
                  child: TodoPage(),
                );
              },
            ),
          );
        },
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: Color(0xFFD97708),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ],
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
