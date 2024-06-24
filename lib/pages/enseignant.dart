// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_application_1/pages/espace_enseignant.dart';


class EnseignantPage extends StatefulWidget {
  const EnseignantPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EnseignantPageState createState() => _EnseignantPageState();
}

class _EnseignantPageState extends State<EnseignantPage> {
  final TextEditingController _identifiantController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();

  bool _isValidIdentifiant(String input) {
    return input.isNotEmpty;
  }

  bool _isValidCIN(String input) {
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
                margin: const EdgeInsets.symmetric(horizontal: 40.0),
                padding: const EdgeInsets.all(40.0),
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
                          Icons.local_library_sharp,
                          size: 24.0,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Espace Enseignant',
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
                          Icons.perm_device_information,
                          size: 24.0,
                          color: Color.fromARGB(255, 2, 78, 140),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            controller: _identifiantController,
                            decoration: const InputDecoration(
                              labelText: 'Identifiant',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.badge_outlined,
                          size: 24.0,
                          color: Color.fromARGB(255, 2, 78, 140),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            controller: _cinController,
                            decoration: const InputDecoration(
                              labelText: 'CIN',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        String identifiant = _identifiantController.text.trim();
                        String cin = _cinController.text.trim();

                        if (!_isValidIdentifiant(identifiant)) {
                          _showErrorDialog(context, 'Identifiant is required.');
                          return;
                        }

                        if (!_isValidCIN(cin)) {
                          _showErrorDialog(context, 'CIN is required.');
                          return;
                        }

                        _registerEnseignant(identifiant, cin);
                      },
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

 void _registerEnseignant(String identifiant, String cin) async {
  DatabaseHelper dbHelper = DatabaseHelper();
  bool isValid = await dbHelper.verifyEnseignant(identifiant, cin);

  if (isValid) {
    Map<String, dynamic>? enseignantInfo = await dbHelper.getEnseignantInfo(identifiant, cin);

    if (enseignantInfo != null) {
      String userName = enseignantInfo['nom'] ?? '';
      String userPrename = enseignantInfo['prenom'] ?? '';

      String userEmail = enseignantInfo['email'] ?? '';
      String userId = identifiant;
      String userCin = cin;
      String userMatricule = enseignantInfo['matricule'] ?? '';
      String userDateNaissance = enseignantInfo['date_naissance'] ?? '';


        String userLieuNaissance = enseignantInfo['lieu_naissance'] ?? '';
      String userNomarabe = enseignantInfo['nomarabe'] ?? '';

      String userPrenomarabe = enseignantInfo['prenomarabe'] ?? '';
      String userLieuNaissancearabe = enseignantInfo['lieu_naissancearabe'] ?? '';

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EspacEnseignantPage(
          userName: userName,
          userPrename: userPrename,
          userId: userId,
          userCin: userCin,
          userEmail: userEmail,
          userMatricule: userMatricule,
          userDateNaissance: userDateNaissance,
          userLieuNaissance: userLieuNaissance,
          userNomarabe: userNomarabe, 
          userPrenomarabe: userPrenomarabe ,
          userLieuNaissancearabe: userLieuNaissancearabe , 

        )),
      );
    } else {
      _showErrorDialog(context, 'Unable to fetch enseignant information.');
    }
  } else {
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
