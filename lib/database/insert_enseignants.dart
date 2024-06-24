
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/database_helper.dart';

Future<void> insertEnseignants() async {
  DatabaseHelper dbHelper = DatabaseHelper();
  await dbHelper.initEnseignantDatabase();

List<Map<String, dynamic>> enseignants = [
  {
    'identifiant': 'teacher123',
    'nom': 'Layla',
    'prenom': 'Ouyoussef',

    'cin': 'A4567890',
    'email': 'john.doe@example.com',
    'matricule': 'TEACHER123',
    'date_naissance': '1980-01-01',
    'password': 'password123',
    'lieu_naissance': 'Ait Boulli ',
    'nomarabe': 'أويوسف',
    'prenomarabe':'ليلى',
    'lieu_naissancearabe': 'أيت بووالي',
  },
  {
    'identifiant': 'layla111',
    'matricule': 'TEACHER123',
    'nom': 'Ouyoussef',
    'prenom': 'Layla',
    'cin': 'IC154736',
    'email': 'Layla.Ouyoussef@gmail.com',
    'date_naissance': '1980-01-01',
    'lieu_naissance': 'Ait Boulli ',
    'nomarabe': 'أويوسف',
    'prenomarabe':'ليلى',
    'lieu_naissancearabe': 'أيت بووالي',

  },
    {
    'identifiant': 'teacher13',
    'nom': ' Doe',
    'prenom': 'John',
    'cin': '127890',
    'email': 'john.doe@example.com',
    'matricule': 'TEACHER123',
    'date_naissance': '1980-01-01',
    'password': 'password123',
    'lieu_naissance': 'Ait Boulli ',
    'nomarabe': 'ليلى',
    'prenomarabe': 'أويوسف',
    'lieu_naissancearabe': 'أيت بووالي',
  },
    {
    'identifiant': 'teacher133',
    'nom': ' Doe',
    'prenom': 'John',
    'cin': '123456',
    'email': 'john.doe@example.com',
    'matricule': 'TEACHER123',
    'date_naissance': '1980-01-01',
    'password': 'password123',
    'lieu_naissance': 'Ait Boulli ',
    'nomarabe': 'ليلى',
    'prenomarabe': 'أويوسف',
    'lieu_naissancearabe': 'أيت بووالي',
  }
  
];
for (var enseignant in enseignants) {
  try {
    int result = await dbHelper.insertEnseignant(enseignant);
    if (result != 0) {
      if (kDebugMode) {
        print('Enseignant inserted successfully.');
      }
    } else {
      if (kDebugMode) {
        print('Failed to insert enseignant.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error inserting enseignant: $e');
    }
  }
}

}
