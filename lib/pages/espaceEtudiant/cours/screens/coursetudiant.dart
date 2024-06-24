import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewerPage extends StatelessWidget {
  final String filePath;

  const PDFViewerPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
        title: const Text(
          'PDF ',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}

class CourseEtudiant extends StatefulWidget {
  final List<Map<String, dynamic>> courseInfo;

  const CourseEtudiant({super.key, required this.courseInfo,});

  @override
  // ignore: library_private_types_in_public_api
  _PagecoursState createState() => _PagecoursState();
}

class _PagecoursState extends State<CourseEtudiant> {
  late List<Map<String, dynamic>> _courseInfo;

  @override
  void initState() {
    super.initState();
    _courseInfo = widget.courseInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          " Voir tous les cours",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/patt.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _courseInfo.isNotEmpty
              ? ListView.builder(
                  itemCount: _courseInfo.length,
                  itemBuilder: (context, index) {
                    String nomCour = _courseInfo[index]['namecour'];
                    String username = _courseInfo[index]['username'];
                    String fichier = _courseInfo[index]['fichier'];

                    return SizedBox(
                      width: 140, // Set the width to the maximum available width
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 236, 240), // Red background color
                          borderRadius: BorderRadius.circular(15), // Change the border radius
                        ),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cours $nomCour',
                                style: const TextStyle(color: Color.fromARGB(255, 2, 78, 140),fontWeight: FontWeight.bold,fontSize: 22),
                              ),
                              const SizedBox(height: 5), // Add space between course name and file path
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PDFViewerPage(filePath: fichier),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Chemin du fichier: $fichier',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5), 
                              const SizedBox(width: 15), 
                              Text(
                                'par Pr. $username',
                                style: const TextStyle(fontStyle: FontStyle.italic,color: Colors.blue,fontSize: 18),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.save_alt,color: Colors.green,),
                           onPressed: () async {
                await saveFileToDevice(fichier);
              },
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Text(
                  'Aucun cours ajouté',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
Future<void> saveFileToDevice(String filePath) async {
    try {
      final String fileName = filePath.split('/').last;
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String appDocPath = appDocDir.path;
      final File localFile = File('$appDocPath/$fileName');
      final File originalFile = File(filePath);

      await localFile.writeAsBytes(await originalFile.readAsBytes());

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fichier enregistré avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de l\'enregistrement du fichier'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  

}