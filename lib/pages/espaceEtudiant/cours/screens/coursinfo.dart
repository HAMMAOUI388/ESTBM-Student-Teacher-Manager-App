import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_application_1/database_helper.dart';


final TextEditingController fileController = TextEditingController();
final TextEditingController nomCourController = TextEditingController();
final TextEditingController filiereController = TextEditingController();

class Coursinfo extends StatefulWidget {
  final String fullName;
  const Coursinfo({super.key, required this.fullName});

  @override
  // ignore: library_private_types_in_public_api
  _CoursinfoState createState() => _CoursinfoState();
}

class _CoursinfoState extends State<Coursinfo> {
  // Initialize an instance of DatabaseHelper
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    // Clear file input field when the widget is initialized
    fileController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/patt.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            height: 500,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Informations sur le cours',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 152, 0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                     controller: nomCourController,
                    decoration: InputDecoration(
                      hintText: 'Nom de cour.....',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 228, 227, 227),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      // You can store the value in a variable if needed
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: filiereController, // Add this line

                    decoration: InputDecoration(
                      hintText: 'Filiere.....',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 228, 227, 227),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      // You can store the value in a variable if needed
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        File file = File(result.files.single.path!);
                        // Set the selected file path to the input field
                        fileController.text = file.path; // Update fileController with the selected file path
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: fileController,
                        decoration: InputDecoration(
                          hintText: 'Choisir un fichier.....',
                          filled: true,
                          fillColor: const Color.fromARGB(255, 228, 227, 227),
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Voulez-vous quitter ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Non"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Oui"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 2, 78, 140),
                        ),
                        child: const Text(
                          "Annuler",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Retrieve values entered by the user
                          String nomCour = nomCourController.text; // Retrieve from TextFormField
                          String filiere = filiereController.text; // Retrieve from TextFormField
                          String fichier = fileController.text; // Retrieve from fileController

                          // Insert course information into the database
                          dbHelper.insertCours({
                            'username': widget.fullName,
                            'namecour': nomCour,
                            'filiere': filiere,
                            'fichier': fichier,
                          }).then((value) {
                            if (value != -1) {
                              // Show success message if insertion is successful
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Le cours a été ajouté avec succès.'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                                fileController.clear();
                  nomCourController.clear(); // Clear Nom de cour field
                 filiereController.clear();
                               
                            } else {
                              // Show error message if insertion fails
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Le cours n\'a pas été ajouté, essayez à nouveau.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 2, 78, 140),
                        ),
                        child: const Text(
                          "Ajouter",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
