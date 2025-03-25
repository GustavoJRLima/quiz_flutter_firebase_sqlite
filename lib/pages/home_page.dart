import 'package:flutter/material.dart';
import '../helpers/firebase_db_helper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  Future<List<Map<String, dynamic>>> scoresCiencia = Future.value([]);
  Future<List<Map<String, dynamic>>> scoresHistoria = Future.value([]);
  Future<List<Map<String, dynamic>>> scoresCultura = Future.value([]);
  Future<List<Map<String, dynamic>>> scoresConhecimentos = Future.value([]);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadScores();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> loadScores() async {
    setState(() {
      scoresCiencia = firebaseDbHelper.getScoresCiencia();
      scoresHistoria = firebaseDbHelper.getScoresHistoria();
      scoresCultura = firebaseDbHelper.getScoresCultura();
      scoresConhecimentos = firebaseDbHelper.getScoresConhecimentos();
    });
  }

  Widget _buildScoreTab(Future<List<Map<String, dynamic>>> futureScores) {
    return FutureBuilder(
      future: futureScores,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Erro ao carregar os dados"));
        }
        if (snapshot.data!.isEmpty) {
          return const Center(child: Text("Nenhum dado encontrado"));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data![index]["name"]),
              subtitle: Text(snapshot.data![index]["score"].toString()),
            );
          },
        );
      },
    );
  }

  Widget _buildQuizButtons() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: [
        _buildQuizButton("Ciência", "/quizciencia"),
        _buildQuizButton("História", "/quizhistoria"),
        _buildQuizButton("Cultura Pop", "/quizcultura"),
        _buildQuizButton("Conhecimentos Gerais", "/quizconhecimentos"),
      ],
    );
  }

  Widget _buildQuizButton(String text, String route) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 12)),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Quiz com Firebase e SQLite"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Seja bem-vindo!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Aqui você pode ver as pontuações dos quizzes e jogar!",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'Atualizar as pontuações',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2),
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: loadScores,
                icon: const Icon(Icons.refresh, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: "Ciência"),
                      Tab(text: "História"),
                      Tab(text: "Cultura Pop"),
                      Tab(text: "Con. Gerais"),
                    ],
                    labelStyle: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      children: [
                        _buildScoreTab(scoresCiencia),
                        _buildScoreTab(scoresHistoria),
                        _buildScoreTab(scoresCultura),
                        _buildScoreTab(scoresConhecimentos),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildQuizButtons(),
          ],
        ),
      ),
    );
  }
}
