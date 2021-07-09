import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:etiqa_todo_flutter/models/todo_model.dart';
import 'package:etiqa_todo_flutter/screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.merriweatherSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: ChangeNotifierProvider(
        create: (context) => TodoModel(),
        child: Homepage(),
      ),
    );
  }
}
