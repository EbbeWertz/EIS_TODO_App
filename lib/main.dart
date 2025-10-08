import 'package:eis_todo_app/model/notifiers/theme_notifier.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_collection_notifier.dart';
import 'package:eis_todo_app/view/widgets/pages/all_lists_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/database/repositories/todo_list_repository.dart';
import 'model/database/repositories/todo_repository.dart';
import 'model/database/todo_database.dart';

void main() {
  final db = TodoDatabase();
  final todoListRepo = TodoListRepository(db);
  final todoRepo = TodoRepository(db);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoListCollectionNotifier(todoListRepo)),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        Provider.value(value: todoRepo), // dan kan de repo doorgegeven worden aan de todoListNotifiers van specifieke list pages
        Provider.value(value: todoListRepo)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeNotifier>();

    return MaterialApp(
      title: 'EIS TODO App',
      debugShowCheckedModeBanner: false,
      theme: buildLightThemeData(),
      darkTheme: buildDarkThemeData(),
      themeMode: themeModel.themeMode,
      home: const AllListsPage(),
    );
  }

  ThemeData buildDarkThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.grey,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }

  ThemeData buildLightThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      useMaterial3: true,
      brightness: Brightness.light,
    );
  }
}
