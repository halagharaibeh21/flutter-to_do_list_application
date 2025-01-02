import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/home_screen.dart';
import 'package:myapp/splash_screen.dart';
import 'package:myapp/hive_model.dart';

ValueNotifier<bool> isDarkTheme = ValueNotifier(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>("todo");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkTheme,
      builder: (context, isDark, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: isDark
              ? ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: const Color(0xFF2C2C2C),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF3D3D3D),
                  ),
                  cardColor: const Color(0xFF3D3D3D),
                  primaryColor: Colors.teal,
                )
              : ThemeData.light().copyWith(
                  scaffoldBackgroundColor: const Color(0xFFFFF9E8),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFFFFD2A0),
                  ),
                  cardColor: Colors.white,
                  primaryColor: Colors.orange,
                ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
