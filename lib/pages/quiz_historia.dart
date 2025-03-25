import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../helpers/firebase_db_helper.dart';
import '../models/question_model.dart';

class QuizHistoria extends StatefulWidget {
  const QuizHistoria({super.key});

  @override
  State<QuizHistoria> createState() => _QuizHistoriaState();
}

class _QuizHistoriaState extends State<QuizHistoria> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  TextEditingController nameController = TextEditingController();
  List<QuestionModel> questions = [];
  String selectedAnswer = "";
  int score = 0;

  Future<void> getQuestions() async {
    questions = await databaseHelper.getQuestionsHistoria();
    setState(() {
      questions = questions;
    });
  }

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Quiz de História")),
      body: Center(
        child:
            questions.isEmpty
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Parabéns! A sua Pontuação foi: $score/10",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "Digite seu nome",
                        ),
                        controller: nameController,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Por favor, preencha o nome para salvar sua pontuação!",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            await firebaseDbHelper.addScoreHistoria(
                              nameController.text,
                              score,
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "Salvar Pontuação e Voltar para a Home",
                        ),
                      ),
                    ],
                  ),
                )
                : Column(
                  children: [
                    SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 0,
                      ),
                      child: Text(
                        questions[0].question,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      children:
                          questions[0].options.map((option) {
                            return RadioListTile(
                              title: Text(option),
                              value: option,
                              groupValue: selectedAnswer,
                              onChanged: (value) {
                                setState(() {
                                  selectedAnswer = value.toString();
                                });
                              },
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 100),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedAnswer == questions[0].answer) {
                          setState(() {
                            score++;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Resposta correta!"),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Resposta incorreta!"),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                        setState(() {
                          questions.removeAt(0);
                          selectedAnswer = "";
                        });
                      },
                      child: const Text("Responder"),
                    ),
                  ],
                ),
      ),
    );
  }
}
