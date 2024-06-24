import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';

    class EnvoiavisPage extends StatelessWidget {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final String fullName;
  final List<String> filieres = ["GI", "ARI", "GP", "GEER", "MLT"];
  EnvoiavisPage({super.key, required this.fullName});
  @override
  Widget build(BuildContext context) {
    String selectedFiliere = filieres[0];
    DatabaseHelper databaseHelper = DatabaseHelper(); // Instantiate DatabaseHelper
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Envoyer des avis aux étudiants',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/patt.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: const Text(
                      'Ecole Supérieure de Technologie Beni Mellal',
                      style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 2, 78, 140), fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Avis',
                          style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 152, 0), fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _subjectController,
                          decoration: const InputDecoration(
                            hintText: 'Sujet',
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: selectedFiliere,
                          onChanged: (String? value) {
                            if (value != null) {
                              selectedFiliere = value;
                            }
                          },
                          items: filieres.map((String filiere) {
                            return DropdownMenuItem<String>(
                              value: filiere,
                              child: Text(filiere),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            hintText: 'Choisir une filière',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _messageController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: 'Écrire.....',
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            String subject = _subjectController.text;
                            String text = _messageController.text;
                            if (subject.isNotEmpty && text.isNotEmpty) {
                              // Insert values into the database
                              await databaseHelper.insertMessage({
                                'subject': subject,
                                'filiere': selectedFiliere,
                                'message': text,
                                'username': fullName,
                              });
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Le message a été envoyé avec succès'),
                                  duration: Duration(seconds: 4),
                                    backgroundColor: Colors.green, // Background color
                                ),
                              );
                              _subjectController.clear();
                              _messageController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Veuillez remplir tous les champs'),
                                  duration: Duration(seconds: 4),
                                  backgroundColor: Colors.red, // Background color
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 2, 78, 140),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                          ),
                          child: const Text(
                            'Envoyer',
                            style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 252, 251, 250), fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: const Text(
                '2024 © ESTBM. All Rights Reserved',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFF193650),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
