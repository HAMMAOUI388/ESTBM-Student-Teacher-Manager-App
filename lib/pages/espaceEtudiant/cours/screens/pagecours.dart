import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatelessWidget {
  final String filePath;

  const PDFViewerPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
        title: const Text(
          'PDF Viewer',
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

class Pagecours extends StatefulWidget {
  final List<Map<String, dynamic>> courseInfo;

  const Pagecours({super.key, required this.courseInfo});

  @override
  // ignore: library_private_types_in_public_api
  _PagecoursState createState() => _PagecoursState();
}

class _PagecoursState extends State<Pagecours> {
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
          "Cours",
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
                    String filiere = _courseInfo[index]['filiere'];
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
                              const SizedBox(height: 5), // Add space between file path and filiere
                              Text(
                                'Filière: $filiere',
                                style: const TextStyle(fontStyle: FontStyle.italic,color: Colors.blue,fontSize: 18),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete,color: Colors.red,),
                            onPressed: () {
                              _confirmDelete(context, nomCour, index);
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

  void _confirmDelete(BuildContext context, String namecour, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirmation"),
        content: const Text("Voulez-vous supprimer cette cour ?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Non"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _deleteCourse(namecour, index);
              setState(() {
              }); // Trigger rebuild after course deletion
            },
            child: const Text("Oui"),
          ),
        ],
      );
    },
  );
}
void _deleteCourse(String namecour, int index) async {
  List<Map<String, dynamic>> updatedCourseInfo = List.from(_courseInfo); // Create a copy of the list

  int result = await DatabaseHelper().deleteCours(namecour);
  if (result != -1) {
    setState(() {
      updatedCourseInfo.removeAt(index); // Remove the item from the copy
      _courseInfo = updatedCourseInfo; // Update the original list
    });
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Le cours a été supprimé avec succès',
          style: TextStyle(color: Colors.white), // Change text color to white
        ),
        backgroundColor: Colors.red, // Change background color to red
      ),
    );
  } 
}
}