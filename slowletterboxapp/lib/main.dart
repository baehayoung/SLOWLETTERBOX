import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slowletterboxapp/provider/letter_provider.dart';
import 'package:slowletterboxapp/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slow Letter Box',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Chassam'),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (BuildContext context) => TabProvider())
      ], child: const Home()),
    );
  }
}
