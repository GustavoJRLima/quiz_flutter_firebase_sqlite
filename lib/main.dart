import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/pages/quiz_ciencia.dart';
import 'package:flutter_quiz_app/pages/quiz_conhecimentos.dart';
import 'package:flutter_quiz_app/pages/quiz_cultura.dart';
import 'package:flutter_quiz_app/pages/quiz_historia.dart';
import '../firebase_options.dart';
import '../pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz com Firebase e SQLite",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const Homepage(),
        "/quizciencia": (context) => const QuizCiencia(),
        "/quizhistoria": (context) => const QuizHistoria(),
        "/quizcultura": (context) => const QuizCultura(),
        "/quizconhecimentos": (context) => const QuizConhecimentos(),
      },
    );
  }
}
