import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_application_1/pages/espace_etudiant.dart';

// ignore: must_be_immutable
class EtudiantPage extends StatelessWidget {
  EtudiantPage({super.key});

  final TextEditingController _apogeeController = TextEditingController();
  final TextEditingController _cneController = TextEditingController();
  final TextEditingController _dateNaissanceController = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper();

  bool _isValidDateFormat(String input) {
    final RegExp regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return regex.hasMatch(input);
  }

  bool _isValidApogee(String input) {
    return input.isNotEmpty;
  }

  bool _isValidCne(String input) {
    return input.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
      ),
      body: Stack(
        children: [
          Image.asset(
            'lib/images/patt.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 100.0, bottom: 160.0, left: 48.0, right: 48.0),
                padding: const EdgeInsets.all(48.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school,
                          size: 24.0,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Espace Étudiant',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 24.0,
                          color: Color.fromARGB(255, 2, 78, 140),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            controller: _apogeeController,
                            decoration: const InputDecoration(
                              labelText: 'Code Apogee',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.security,
                          size: 24.0,
                          color: Color.fromARGB(255, 2, 78, 140),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            controller: _cneController,
                            decoration: const InputDecoration(
                              labelText: 'Code Massar',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 24.0,
                          color: Color.fromARGB(255, 2, 78, 140),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            controller: _dateNaissanceController,
                            decoration: const InputDecoration(
                              labelText: 'Date de naissance',
                              hintText: 'YYYY-MM-DD',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    ElevatedButton(
                      onPressed: () => _registerEtudiant(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        backgroundColor: const Color.fromARGB(255, 67, 4, 194),
                      ),
                      child: const Text(
                        'Connecter',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 246, 245, 248),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _registerEtudiant(BuildContext context) async {
    String apogee = _apogeeController.text.trim();
    String cne = _cneController.text.trim();
    String dateNaissance = _dateNaissanceController.text.trim();

    if (!_isValidApogee(apogee)) {
      _showErrorDialog(context, 'Apogee is required.');
      return;
    }

    if (!_isValidCne(cne)) {
      _showErrorDialog(context, 'Code Massar is required.');
      return;
    }
    
    if (!_isValidDateFormat(dateNaissance)) {
      _showErrorDialog(context, 'Date de Naissance is required.');
      return;
    }

    bool isValid = await dbHelper.verifyEtudiant(apogee, cne, dateNaissance);

    if (isValid) {
      Map<String, dynamic>? studentInfo = await dbHelper.getStudentInfo(apogee, cne, dateNaissance);

      if (studentInfo != null) {
        String userApogee = studentInfo['apogee'] ?? '';
        String userName = studentInfo['nom'] ?? '';
        String userPrename = studentInfo['prenom'] ?? '';
        String userDateNaissance = studentInfo['date_naissance'] ?? '';
        String userCne = studentInfo['cne'] ?? '';
        String userCin = studentInfo['cin'] ?? '';
        String userFiliere = studentInfo['filiere'] ?? '';
        String userLieuNaissance = studentInfo['lieu_naissance'] ?? '';
        String userLieuNaissancearabe = studentInfo['lieu_naissancearabe'] ?? '';
        String userNomarabe = studentInfo['nomarabe'] ?? '';
        String userPrenomarabe = studentInfo['prenomarabe'] ?? '';
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => EspaceEtudiantPage(
              userApogee: userApogee,
              userName: userName,
              userPrename: userPrename,
              userDateNaissance: userDateNaissance,
              userCne: userCne,
              userCin: userCin,
              userFiliere: userFiliere,
              userLieuNaissance: userLieuNaissance,
              userNomarabe: userNomarabe,
              userPrenomarabe: userPrenomarabe,
              userLieuNaissancearabe: userLieuNaissancearabe,
            ),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        _showErrorDialog(context, 'Unable to fetch enseignant information.');
      }
    } else {
      // ignore: use_build_context_synchronously
      _showErrorDialog(context, 'Incorrect credentials. Please try again.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
