import '../models/question_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('quiz_flutter.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions_ciencia (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        options TEXT NOT NULL,
        answer TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE questions_historia (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        options TEXT NOT NULL,
        answer TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE questions_cultura (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        options TEXT NOT NULL,
        answer TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE questions_conhecimentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        options TEXT NOT NULL,
        answer TEXT NOT NULL
      )
    ''');

    await db.execute('''
      INSERT INTO questions_ciencia (question, options, answer)
      VALUES
        ('Qual é o símbolo químico do ouro?', 'Au;Ag;Pb;Fe', 'Au'),
        ('Quem inventou a lâmpada elétrica?', 'Thomas Edison;Nikola Tesla;Alexander Graham Bell;Isaac Newton', 'Thomas Edison'),
        ('Qual planeta é conhecido como o Planeta Vermelho?', 'Terra;Vênus;Marte;Júpiter', 'Marte'),
        ('O que significa a sigla "WWW" na internet?', 'World Wide Web;Web World Wide;Wireless Wide Web;World Web Window', 'World Wide Web'),
        ('Qual é o maior órgão do corpo humano?', 'Coração;Fígado;Pele;Pulmões', 'Pele'),
        ('Qual gás é essencial para a respiração humana?', 'Hidrogênio;Oxigênio;Dióxido de Carbono;Nitrogênio', 'Oxigênio'),
        ('Quem desenvolveu a teoria da relatividade?', 'Isaac Newton;Albert Einstein;Galileu Galilei;Stephen Hawking', 'Albert Einstein'),
        ('O que mede a unidade Hertz (Hz)?', 'Frequência;Velocidade;Força;Temperatura', 'Frequência'),
        ('Qual dispositivo é usado para medir a temperatura?', 'Barômetro;Higrômetro;Termômetro;Anemômetro', 'Termômetro'),
        ('Qual destes não é um tipo de computador?', 'Notebook;Tablet;Smartphone;Heliógrafo', 'Heliógrafo')
    ''');

    await db.execute('''
      INSERT INTO questions_historia (question, options, answer)
      VALUES
        ('Quem foi o primeiro imperador de Roma?', 'Júlio César;Augusto;Nero;Calígula', 'Augusto'),
        ('Em que ano ocorreu a Revolução Francesa?', '1776;1789;1812;1848', '1789'),
        ('Quem descobriu o Brasil?', 'Cristóvão Colombo;Pedro Álvares Cabral;Vasco da Gama;Fernão de Magalhães', 'Pedro Álvares Cabral'),
        ('Qual guerra foi encerrada com o Tratado de Versalhes?', 'Primeira Guerra Mundial;Segunda Guerra Mundial;Guerra Fria;Guerra do Vietnã', 'Primeira Guerra Mundial'),
        ('Qual das sete maravilhas do mundo antigo ainda existe?', 'Colosso de Rodes;Mausoléu de Halicarnasso;Pirâmide de Quéops;Jardins Suspensos da Babilônia', 'Pirâmide de Quéops'),
        ('Quem foi o líder da Revolução Russa de 1917?', 'Josef Stalin;Leon Trotsky;Vladimir Lenin;Mikhail Gorbachev', 'Vladimir Lenin'),
        ('Que evento marcou o início da Idade Média?', 'Queda de Constantinopla;Queda do Império Romano do Ocidente;Guerra dos Cem Anos;Revolução Industrial', 'Queda do Império Romano do Ocidente'),
        ('Quem foi o primeiro presidente dos Estados Unidos?', 'Abraham Lincoln;George Washington;Thomas Jefferson;Theodore Roosevelt', 'George Washington'),
        ('Qual civilização construiu Machu Picchu?', 'Astecas;Maias;Incas;Olmecas', 'Incas'),
        ('Em que ano caiu o Muro de Berlim?', '1989;1991;1975;1963', '1989')
    ''');

    await db.execute('''
      INSERT INTO questions_cultura (question, options, answer)
      VALUES
        ('Qual o nome do vilão principal em "O Senhor dos Anéis"?', 'Saruman;Sauron;Gollum;Gandalf', 'Sauron'),
        ('Em que ano foi lançado o primeiro filme da franquia "Harry Potter"?', '1999;2001;2003;2005', '2001'),
        ('Qual desses super-heróis pertence à DC Comics?', 'Homem-Aranha;Capitão América;Batman;Homem de Ferro', 'Batman'),
        ('Qual banda lançou o álbum "Abbey Road"?', 'The Beatles;Queen;The Rolling Stones;Pink Floyd', 'The Beatles'),
        ('Quem interpretou Tony Stark no Universo Cinematográfico da Marvel?', 'Chris Hemsworth;Chris Evans;Robert Downey Jr.;Mark Ruffalo', 'Robert Downey Jr.'),
        ('Qual dessas séries é um spin-off de "Breaking Bad"?', 'Better Call Saul;House of Cards;The Wire;Dexter', 'Better Call Saul'),
        ('Qual desses jogos pertence à franquia "The Legend of Zelda"?', 'Skyrim;The Witcher;Breath of the Wild;Dark Souls', 'Breath of the Wild'),
        ('Qual é o nome do protagonista de "Naruto"?', 'Sasuke;Itachi;Kakashi;Naruto', 'Naruto'),
        ('Quem é o criador da série "Game of Thrones"?', 'J.K. Rowling;George R.R. Martin;J.R.R. Tolkien;Stephen King', 'George R.R. Martin'),
        ('Qual desses filmes é da Pixar?', 'Shrek;Toy Story;Frozen;Madagascar', 'Toy Story')
    ''');

    await db.execute('''
      INSERT INTO questions_conhecimentos (question, options, answer)
      VALUES
        ('Qual é o animal mais rápido do mundo?', 'Guepardo;Falcão-peregrino;Golfinho;Cavalo', 'Falcão-peregrino'),
        ('Quantos continentes existem na Terra?', '5;6;7;8', '7'),
        ('Qual é o maior oceano do mundo?', 'Atlântico;Pacífico;Índico;Ártico', 'Pacífico'),
        ('Qual país tem a maior população do mundo?', 'China;Índia;Estados Unidos;Indonésia', 'China'),
        ('Qual é o idioma mais falado no mundo?', 'Inglês;Espanhol;Mandarim;Hindi', 'Mandarim'),
        ('Qual desses países não faz parte do Reino Unido?', 'Inglaterra;Escócia;Irlanda do Norte;Irlanda', 'Irlanda'),
        ('Qual é a moeda oficial do Japão?', 'Yuan;Won;Iene;Dólar', 'Iene'),
        ('O que significa a sigla "NASA"?', 'National Aeronautics and Space Administration;North American Space Agency;New Age Science Academy;National Air and Space Administration', 'National Aeronautics and Space Administration'),
        ('Qual país é conhecido como "Terra do Sol Nascente"?', 'China;Japão;Coreia do Sul;Tailândia', 'Japão'),
        ('Quantas cordas tem um violino?', '4;5;6;7', '4')
    ''');
  }

  Future<List<QuestionModel>> getQuestionsCiencia() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('questions_ciencia');

    return List.generate(maps.length, (i) {
      return QuestionModel(
        id: maps[i]['id'],
        question: maps[i]['question'],
        options: maps[i]['options'].split(';'),
        answer: maps[i]['answer'],
      );
    });
  }

  Future<List<QuestionModel>> getQuestionsHistoria() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'questions_historia',
    );

    return List.generate(maps.length, (i) {
      return QuestionModel(
        id: maps[i]['id'],
        question: maps[i]['question'],
        options: maps[i]['options'].split(';'),
        answer: maps[i]['answer'],
      );
    });
  }

  Future<List<QuestionModel>> getQuestionsCultura() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('questions_cultura');

    return List.generate(maps.length, (i) {
      return QuestionModel(
        id: maps[i]['id'],
        question: maps[i]['question'],
        options: maps[i]['options'].split(';'),
        answer: maps[i]['answer'],
      );
    });
  }

  Future<List<QuestionModel>> getQuestionsConhecimentos() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'questions_conhecimentos',
    );

    return List.generate(maps.length, (i) {
      return QuestionModel(
        id: maps[i]['id'],
        question: maps[i]['question'],
        options: maps[i]['options'].split(';'),
        answer: maps[i]['answer'],
      );
    });
  }
}
