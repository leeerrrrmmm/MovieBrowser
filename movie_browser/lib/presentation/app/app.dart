import 'package:flutter/material.dart';
import 'package:movie_browser/presentation/main/main_screen.dart';

/// [App]
class App extends StatelessWidget {
  /// [App] constructor
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
