import 'package:eis_todo_app/model/notifiers/theme_notifier.dart';
import 'package:eis_todo_app/model/notifiers/todo_lists_notifier.dart';
import 'package:eis_todo_app/view/widgets/pages/all_lists_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoListsNotifier()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
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
        seedColor: Colors.cyan,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }

  ThemeData buildLightThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      useMaterial3: true,
      brightness: Brightness.light,
    );
  }
}
