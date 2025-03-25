import 'package:firebase_database/firebase_database.dart';

class FirebaseDbHelper {
  final DatabaseReference _databaseCiencia = FirebaseDatabase.instance.ref(
    "scoresCiencia",
  );
  final DatabaseReference _databaseHistoria = FirebaseDatabase.instance.ref(
    "scoresHistoria",
  );
  final DatabaseReference _databaseCultura = FirebaseDatabase.instance.ref(
    "scoresCultura",
  );
  final DatabaseReference _databaseConhecimentos = FirebaseDatabase.instance
      .ref("scoresConhecimentos");

  Future<void> addScoreCiencia(String name, int score) async {
    final newScore = _databaseCiencia.push();

    await newScore.set({"name": name, "score": score});
  }

  Future<void> addScoreHistoria(String name, int score) async {
    final newScore = _databaseHistoria.push();

    await newScore.set({"name": name, "score": score});
  }

  Future<void> addScoreCultura(String name, int score) async {
    final newScore = _databaseCultura.push();

    await newScore.set({"name": name, "score": score});
  }

  Future<void> addScoreConhecimentos(String name, int score) async {
    final newScore = _databaseConhecimentos.push();

    await newScore.set({"name": name, "score": score});
  }

  Future<List<Map<String, dynamic>>> getScoresCiencia() async {
    final snapshot = await _databaseCiencia.child("").get();
    if (snapshot.exists) {
      final scores = <Map<String, dynamic>>[];
      (snapshot.value as Map).forEach((key, value) {
        scores.add({"name": value["name"], "score": value["score"]});
      });
      return scores;
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getScoresHistoria() async {
    final snapshot = await _databaseHistoria.child("").get();
    if (snapshot.exists) {
      final scores = <Map<String, dynamic>>[];
      (snapshot.value as Map).forEach((key, value) {
        scores.add({"name": value["name"], "score": value["score"]});
      });
      return scores;
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getScoresCultura() async {
    final snapshot = await _databaseCultura.child("").get();
    if (snapshot.exists) {
      final scores = <Map<String, dynamic>>[];
      (snapshot.value as Map).forEach((key, value) {
        scores.add({"name": value["name"], "score": value["score"]});
      });
      return scores;
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getScoresConhecimentos() async {
    final snapshot = await _databaseConhecimentos.child("").get();
    if (snapshot.exists) {
      final scores = <Map<String, dynamic>>[];
      (snapshot.value as Map).forEach((key, value) {
        scores.add({"name": value["name"], "score": value["score"]});
      });
      return scores;
    } else {
      return [];
    }
  }
}
