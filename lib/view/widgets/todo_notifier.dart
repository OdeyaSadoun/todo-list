import 'package:flutter/material.dart';
import 'package:todo_list_app/infrastructures/events/event_bus.dart';
import '../../infrastructures/events/event_bus.dart';
import '../../infrastructures/events/todo_events.dart';

class TodoNotifier extends StatefulWidget {
  const TodoNotifier({super.key});

  @override
  _TodoNotifierState createState() => _TodoNotifierState();
}

class _TodoNotifierState extends State<TodoNotifier> {
  @override
  void initState() {
    super.initState();

    eventBus.on<TodoAddedEvent>().listen((event) {
      print('Task added: ${event.todo.title}');
      // אפשר לבצע פעולות נוספות כמו עדכון UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(); 
  }
}
