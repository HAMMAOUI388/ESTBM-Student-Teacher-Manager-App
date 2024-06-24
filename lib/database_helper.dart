import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _db;
  bool _isInitialized = false;

  Future<void> initEtudiantDatabase() async {
    if (_isInitialized) {
      return;
    }
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'etudiant.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS etudiants (
            apogee TEXT PRIMARY KEY,
            nom TEXT,
            prenom TEXT,
            date_naissance DATE,
            cne TEXT,
            cin TEXT,
            filiere TEXT,
            lieu_naissance TEXT,
            nomarabe TEXT,
            prenomarabe TEXT,
            lieu_naissancearabe TEXT,
            fichier BLOB,
            namecour TEXT,
            annee_scolaire INTEGER
          )
        ''');
      },
    );
    _isInitialized = true;
  }
Future<Map<String, dynamic>?> getStudentInfo(String appogee, String cne, [String? dateNaissance, String? filiere, int? anneeScolaire]) async {

    await initEtudiantDatabase();

  List<Map<String, Object?>> result;
  // ignore: unnecessary_null_comparison
  if (dateNaissance != null ) {
      result = await _db.query(
      'etudiants',
      columns: [
        'apogee',
        'cne ',
        'nom',
        'prenom ',
        'date_naissance',
        'cin ',
        'filiere ',
        'lieu_naissance ',
        'nomarabe ',
        'prenomarabe ',
        'lieu_naissancearabe ',
        'annee_scolaire'
      ],
      where: 'apogee = ? AND cne = ? AND date_naissance = ?',
      whereArgs: [appogee, cne, dateNaissance],
    );
    } else {
    result = await _db.query(
      'etudiants',
      columns: [
        'apogee',
        'cne ',
        'nom',
        'prenom ',
        'date_naissance',
        'cin ',
        'filiere ',
        'lieu_naissance ',
        'nomarabe ',
        'prenomarabe ',
        'lieu_naissancearabe ',
        'annee_scolaire'
      ],
      where: 'apogee = ? AND cne = ?',
      whereArgs: [appogee, cne],
    );
  }
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<int> insertEtudiant(Map<String, dynamic> etudiant) async {
    await initEtudiantDatabase();
    try {
      var res = await _db.insert('etudiants', etudiant,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      return res;
    } catch (e) {
      if (kDebugMode) {
        print('Error inserting etudiants: $e');
      }
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getEtudiants() async {
    await initEtudiantDatabase();
    var result = await _db.query('etudiants');
    return result;
  }

  Future<bool> verifyEtudiant(
      String apogee, String cne, String dateNaissance) async {
    await initEtudiantDatabase();
    var result = await _db.query(
      'etudiants',
      where: 'apogee = ? AND cne = ? AND date_naissance = ?',
      whereArgs: [apogee, cne, dateNaissance],
    );
    return result.isNotEmpty;
  }

  Future<void> initEnseignantDatabase() async {
    if (_isInitialized) {
      return;
    }
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'enseignant.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS enseignants (
            identifiant TEXT PRIMARY KEY,
            nom TEXT,
            prenom TEXT,
            cin TEXT,
            email TEXT,
            matricule TEXT,
            date_naissance DATE,
            lieu_naissance TEXT,
            nomarabe TEXT,
            prenomarabe TEXT,
            lieu_naissancearabe TEXT
          )
        ''');
      },
    );

    _isInitialized = true;
  }

  Future<Map<String, dynamic>?> getEnseignantInfo(
      String identifiant, String cin) async {
    await initEnseignantDatabase();

    var result = await _db.query(
      'enseignants',
      columns: [
        'nom',
        'prenom',
        'cin',
        'email',
        'identifiant',
        'matricule',
        'date_naissance',
        'lieu_naissance',
        'nomarabe',
        'prenomarabe',
        'lieu_naissancearabe'
      ],
      where: 'identifiant = ? AND cin = ?',
      whereArgs: [identifiant, cin],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<int> insertEnseignant(Map<String, dynamic> enseignant) async {
    await initEnseignantDatabase();
    try {
      var res = await _db.insert('enseignants', enseignant,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      return res;
    } catch (e) {
      if (kDebugMode) {
        print('Error inserting enseignant: $e');
      }
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getEnseignants() async {
    await initEnseignantDatabase();
    var result = await _db.query('enseignants');
    return result;
  }

  Future<bool> verifyEnseignant(String identifiant, String cin) async {
    await initEnseignantDatabase();
    var result = await _db.query(
      'enseignants',
      where: 'identifiant = ? AND cin = ?',
      whereArgs: [identifiant, cin],
    );
    return result.isNotEmpty;
  }

  Future<void> initCoursDatabase() async {
    if (_isInitialized) {
      return;
    }

    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cours.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS cours (
            username TEXT,
            fichier BLOB,
            filiere TEXT,
            namecour TEXT
          )
        ''');
      },
    );



    _isInitialized = true;
  }

  Future<int> insertCours(Map<String, dynamic> cours) async {
    await initCoursDatabase();
    try {
      var res = await _db.insert('cours', cours,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      return res;
    } catch (e) {
      if (kDebugMode) {
        print('Error inserting cours: $e');
      }
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getCoursInfoByfiliere(
      String filiere) async {
    await initCoursDatabase();
    var result = await _db.query(
      'cours',
      columns: ['namecour', 'username', 'fichier'],
      where: ' filiere = ?',
      whereArgs: [filiere],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getCoursInfo(String username) async {
    await initCoursDatabase();
    var result = await _db.query(
      'cours',
      columns: ['namecour', 'filiere', 'fichier'],
      where: 'username = ?',
      whereArgs: [username],
    );
    return result;
  }

  Future<int> deleteCours(String namecour) async {
    await initCoursDatabase();
    try {
      return await _db.delete(
        'cours',
        where: 'namecour = ?',
        whereArgs: [namecour],
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting cours: $e');
      }
      return -1;
    }
  }

  // New methods for messages database and table

  Future<void> initMessagesDatabase() async {
    if (_isInitialized) {
      return;
    }

    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'messages.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS messages (
            subject TEXT,
            filiere TEXT,
            message TEXT,
            username TEXT
          )
        ''');
      },
    );

    _isInitialized = true;
  }
  Future<int> insertMessage(Map<String, dynamic> message) async {
    await initMessagesDatabase();
    try {
      var res = await _db.insert('messages', message,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      return res;
    } catch (e) {
      if (kDebugMode) {
        print('Error inserting message: $e');
      }
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getMessagesbyfiliere(String filiere) async {
    await initMessagesDatabase();
    var result = await _db.query(
      'messages',
      columns: ['subject', 'message','username'],
      where: 'filiere = ?',
      whereArgs: [filiere],
    );
    return result;
  }
}
