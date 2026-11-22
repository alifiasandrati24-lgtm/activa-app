
import 'package:flutter/material.dart';

import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ActivityViewModel();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activa',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF100D12),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF3D9A),
          secondary: Color(0xFFFF80BC),
          surface: Color(0xFF211B24),
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF100D12),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        fontFamily: 'Roboto',
      ),
      home: HomeView(viewModel: viewModel),
    );
  }
}
