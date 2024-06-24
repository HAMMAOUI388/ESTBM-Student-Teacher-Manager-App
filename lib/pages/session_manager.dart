import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _apogeeKey = 'apogee';
  static const String _cneKey = 'cne';
  static const String _nomKey = 'nom';
  static const String _prenomKey = 'prenom';
  static const String _cinKey = 'cin';
  static const String _villeKey = 'ville';
  static const String _anneeScolaireKey = 'anneeScolaire';
  static const String _dateNaissanceKey = 'dateNaissance';
  static const String _filiereKey = 'filiere';

  static Future<void> saveSessionInfo({
    required String cne,
    required String apogee,
    required String nom,
    required String prenom,
    required String cin,
    required String ville,
    required int anneeScolaire,
    required String dateNaissance,
    required String filiere, required String appogee,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_apogeeKey, apogee);
      await prefs.setString(_cneKey, cne);
      await prefs.setString(_nomKey, nom);
      await prefs.setString(_prenomKey, prenom);
      await prefs.setString(_cinKey, cin);
      await prefs.setString(_villeKey, ville);
      await prefs.setInt(_anneeScolaireKey, anneeScolaire);
      await prefs.setString(_dateNaissanceKey, dateNaissance);
      await prefs.setString(_filiereKey, filiere);
    } catch (e) {
      // ignore: avoid_print
      print('Error saving session info: $e');
      throw Exception('Error saving session information');
    }
  }

  static Future<Map<String, dynamic>> getSessionInfo() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'apogee': prefs.getString(_apogeeKey),
      'cne': prefs.getString(_cneKey),
      'nom': prefs.getString(_nomKey),
      'prenom': prefs.getString(_prenomKey),
      'cin': prefs.getString(_cinKey),
      'ville': prefs.getString(_villeKey),
      'anneeScolaire': prefs.getInt(_anneeScolaireKey),
      'dateNaissance': prefs.getString(_dateNaissanceKey),
      'filiere': prefs.getString(_filiereKey),
    };
  } catch (e) {
    // ignore: avoid_print
    print('Error retrieving session info: $e');
    throw Exception('Error retrieving session information');
  }
}

}
