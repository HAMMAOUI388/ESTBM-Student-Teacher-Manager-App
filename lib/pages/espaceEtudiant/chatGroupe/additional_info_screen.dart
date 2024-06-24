import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/chatGroupe/chat_groupe_service.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/chatGroupe/communication_group.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';

// ignore: must_be_immutable
class AdditionalInfoForm extends StatelessWidget {
  AdditionalInfoForm({super.key});

  final TextEditingController _apogeeController = TextEditingController();
  final TextEditingController _cneController = TextEditingController();
  final TextEditingController _filiereController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper();




// Inside your AdditionalInfoForm class

// ignore: unused_element
Future<void> _selectAndUploadFile() async {
  // Open file picker to select file
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null && result.files.isNotEmpty) {
    PlatformFile file = result.files.first;
    try {
      // Upload the file and get the URL
      String downloadURL = await _uploadFileToStorage(file);
      if (kDebugMode) {
        print('Uploaded file available at: $downloadURL');
      }
      // Optionally, you can open the file using the URL
     // _openFile(downloadURL);
    } catch (e) {
      if (kDebugMode) {
        print('Error during file upload: $e');
      }
    }
  }
}

Future<String> _uploadFileToStorage(PlatformFile file) async {
  try {
    // Define the storage reference
    final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('uploads/${file.name}');
    // Upload the file
    final uploadTask = storageRef.putFile(File(file.path!));
    // Await the upload task to complete
    final snapshot = await uploadTask;
    // Get the download URL of the uploaded file
    final downloadURL = await snapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print("File uploaded at: $downloadURL");
    }
    return downloadURL;
  } catch (e) {
    if (kDebugMode) {
      print("Failed to upload file: $e");
    }
    rethrow;
  }
}








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Groupe'),
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
                margin: const EdgeInsets.only(
                  top: 100.0,
                  bottom: 160.0,
                  left: 48.0,
                  right: 48.0,
                ),
                padding: const EdgeInsets.all(48.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble,
                          size: 24.0,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Vos informations',
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
                          Icons.info,
                          size: 24.0,
                          color: Color.fromARGB(255, 2, 78, 140),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            controller: _cneController,
                            decoration: const InputDecoration(
                              labelText: 'CNE',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.perm_identity_sharp,
                          size: 24.0,
                          color: Color.fromARGB(255, 2, 78, 140),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            controller: _apogeeController,
                            decoration: const InputDecoration(
                              labelText: 'Apogee',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.keyboard_option_key,
                          size: 24.0,
                          color: Color.fromARGB(255, 2, 78, 140),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            controller: _filiereController,
                            decoration: const InputDecoration(
                              labelText: 'Filiere',
                              hintText: 'Exp: GI',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.analytics,
                          size: 24.0,
                          color: Color.fromARGB(255, 2, 78, 140),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            controller: _yearController,
                            decoration: const InputDecoration(
                              labelText: 'Annee scolaire',
                              hintText: '1ere annee : 1',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        verifyStudentInfo(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        backgroundColor: const Color.fromARGB(255, 67, 4, 194),
                      ),
                      child: const Text(
                        'Entrer',
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



  
Future<void> verifyStudentInfo(BuildContext context) async {
  String cne = _cneController.text;
  String appogee = _apogeeController.text;
  String filiere = _filiereController.text;
  int anneeScolaire = int.tryParse(_yearController.text) ?? 0;

  Map<String, dynamic>? studentInfo = await dbHelper.getStudentInfo(appogee, cne);

  if (studentInfo != null) {
    int? dbAnneeScolaire = studentInfo['annee_scolaire'];
    String? dbFiliere = studentInfo['filiere'];
    String? nom = studentInfo['nom'];
    String? prenom = studentInfo['prenom']; 

    if (dbAnneeScolaire != null &&
        dbFiliere != null &&
        dbAnneeScolaire == anneeScolaire &&
        dbFiliere == filiere) {


      // Fetch chat group id from Firestore based on the student's input filiere
      String chatGroupId = await fetchChatGroupId(filiere);
      if (chatGroupId.isNotEmpty) {
        // Fetch chat groups for the student
        List<QueryDocumentSnapshot<Object?>> chatGroups = await ChatGroupService.getChatGroupsForStudent(filiere, anneeScolaire);

        // Navigate to the CommunicationGroupPage
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => CommunicationGroupPage(
              cne: cne,
              appogee: appogee,
              anneeScolaire: anneeScolaire,
              filiere: filiere,
              chatGroupId: chatGroups,
              senderName: '$prenom $nom', // Pass sender's name to CommunicationGroupPage
            ),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aucun groupe trouvé pour cette filière.'),
          ),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('L\'année scolaire ou la filière est incorrecte pour accéder au chat.'),
        ),
      );
    }
  } else {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Étudiant non trouvé.'),
      ),
    );
  }
}

Future<String> fetchChatGroupId(String filiere) async {
  try {
    // Query Firestore to fetch the chatGroupId based on the student's input filiere
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('EST-groupes')
        .where('Filiere', isEqualTo: filiere)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Return the chatGroupId of the first document found
      return snapshot.docs.first.id;
    } else {
      // If no group is found for the given filiere, return an empty string
      return '';
    }
  } catch (e) {
    // Handle any errors that occur during the Firestore query
    if (kDebugMode) {
      print('Error fetching chat group id: $e');
    }
    return ''; // Return empty string in case of error
  }
}

}