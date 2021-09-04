// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';


void main() => runApp(TodoApp());


class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Todo List',
      home: TodoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    
    if(task.length > 0) {
    
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mark "${_todoItems[index]}" as done?'),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
             
              onPressed: () => Navigator.of(context).pop()
            ),
            FlatButton(
              child: Text('MARK AS DONE'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

 
  Widget _buildTodoList() {
    return  ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
    
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);

        } return build(context);
      } 
    );
  }

 
  Widget _buildTodoItem(String todoText, int index) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(left: 8, right: 8, top: 6),
      child: ListTile(
        
        title: Text(todoText),
        onTap: () => _promptRemoveTodoItem(index)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo List'),
        
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: Icon(Icons.add)
      ),
    );
  }

  void _pushAddTodoScreen() {
  
    Navigator.of(context).push(
     
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add your new task')
            ),
            body: Container(
              padding: EdgeInsets.all(18),
              child: TextField(
                autofocus: true,
                onSubmitted: (val) {
                  _addTodoItem(val);
                  Navigator.pop(context); 
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter something to do...',
                  contentPadding: const EdgeInsets.all(16.0)
                ),
              ),
            ),
          
          );
        }
      )
    );
  }
}