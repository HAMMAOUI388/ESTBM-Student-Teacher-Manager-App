// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/database_helper.dart';

Future<void> insertEtudiants() async {
  DatabaseHelper dbHelper = DatabaseHelper();
  await dbHelper.initEtudiantDatabase();
  List<Map<String, dynamic>> etudiants = [
   {
     'apogee': '23245678',
     'nom': 'ouyoussef',
     'prenom': 'layla',
     'cin': 'IC104436',
     'cne': 'L12345677',
     'date_naissance': '1980-01-01',
     'lieu_naissance': 'Ait Boulli ',
     'nomarabe': 'أويوسف',
     'prenomarabe':'ليلى',
     'lieu_naissancearabe': 'أيت بووالي',
     'filiere': 'GI',
     'annee_scolaire' : 2,
  },
     {
     'apogee': '98765432',
     'nom': 'Aari',
     'prenom': 'Mohamed',
     'cin': 'IA12345',
     'cne': 'L123456789',
     'date_naissance': '2003-03-15',
     'lieu_naissance': 'el ksiba ',
     'nomarabe': 'عاري',
     'prenomarabe':'محمد',
     'lieu_naissancearabe': 'القصيبه',
     'filiere': 'GI',
     'annee_scolaire' : 2,
  },

  {
     'apogee': '12345678',
     'nom': 'Hammaoui ',
     'prenom': 'Fatima',
     'cin': 'IC104436',
     'cne': 'X12345678',
     'date_naissance': '2003-02-01',
     'lieu_naissance': 'Elksiba ',
     'nomarabe': 'حماوي',
     'prenomarabe':'فاطمه',
     'lieu_naissancearabe': 'القصيبه ',
     'filiere': 'GI',
     'annee_scolaire' : 2,
  },


  ];

  for (var etudiant in etudiants) {
    try {
      int result = await dbHelper.insertEtudiant(etudiant);
      if (result != 0) {
        if (kDebugMode) {
          print('Etud inserted successfully.');
        }
      } else {
        if (kDebugMode) {
          print('Failed to insert etud.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error inserting etud: $e');
      }
    }
  }
}
