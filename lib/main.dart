import 'package:flutter/material.dart';
import 'package:todo/features/todo/presentation/pages/todo_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/todo/data/models/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  // Open the box
  await Hive.openBox<TodoModel>('todos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 252, 249, 249),
        colorScheme: ColorScheme.light(
            primary: const Color.fromARGB(255, 210, 68, 238),
            secondary: const Color.fromARGB(255, 250, 242, 242)),
      ),
      title: 'todo',
      home: TodoPage(),
    );
  }
}
