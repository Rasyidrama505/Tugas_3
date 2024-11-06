import 'package:flutter/material.dart';
import 'package:pertemuan7/models/anime_model.dart';
import 'package:pertemuan7/shared_pref/shared_pref.dart';
import 'package:pertemuan7/views/list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AnimeListScreen(),
    );
  }
}