import 'package:flutter/material.dart';
import 'package:news_application/app_dio.dart';
import 'package:news_application/ui/news_main.dart';

void main() async{
  AppDio.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,

      ),
      home: const NewsMainScreen(),
    );
  }
}

