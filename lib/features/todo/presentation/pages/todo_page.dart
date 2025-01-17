import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/presentation/components/my_list_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({
    super.key,
  });

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  late Box<TodoModel> todoBox;
  final TextEditingController addTodoTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<TodoModel>('todos'); // Initialize the Hive box
  }

  @override
  void dispose() {
    addTodoTextController.dispose();
    super.dispose();
  }

  // show dialog
  void showTodoDialog(BuildContext context,
      {TodoModel? existingTodo, int? index}) {
    // Set the initial values for editing or clear for adding
    if (existingTodo != null) {
      addTodoTextController.text = existingTodo.title;
    } else {
      addTodoTextController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(existingTodo == null ? 'Add Todo' : 'Edit Todo'),
          content: TextField(
            controller: addTodoTextController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTitle = addTodoTextController.text.trim();
                if (newTitle.isNotEmpty) {
                  if (existingTodo == null) {
                    // Add new todo
                    setState(() {
                      todoBox
                          .add(TodoModel(title: capitalizeEachWord(newTitle)));
                    });
                    addTodoTextController.clear();
                  } else if (index != null) {
                    // Update existing todo
                    setState(() {
                      todoBox.putAt(
                          index,
                          TodoModel(
                              title: capitalizeEachWord(newTitle),
                              isCompleted: existingTodo.isCompleted));
                    });
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(existingTodo == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: .5,
        shadowColor: Colors.grey,
        title: Center(
          child: const Text(
            'Your todos',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 25, color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: todoBox.values.length,
        itemBuilder: (context, index) {
          // retrieve the todo items at the index
          final todo = todoBox.getAt(index);
          return MyListTile(
            title: todo?.title ?? 'no titile',
            onEdit: () =>
                showTodoDialog(context, existingTodo: todo, index: index),
            onDelete: () {
              setState(() {
                todoBox.deleteAt(index);
              });
            },
            onToggle: (value) {
              setState(() {
                todo.isCompleted = !todo.isCompleted;
              });
            },
            isCompleted: todo!.isCompleted,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => showTodoDialog(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
