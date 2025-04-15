import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/rule_screen.dart';
import 'screens/game_screen.dart';
import 'providers/game_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Garame',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/game': (context) => const GameScreen(),
        '/rules': (context) => const RulesScreen(),
      },
    );
  }
}