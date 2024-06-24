import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/cours/screens/coursinfo.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/cours/screens/pagecours.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/cours/screens/pagesnocour.dart';

class AddCoursePage extends StatefulWidget {
  final String fullName;

  const AddCoursePage({super.key, required this.fullName});

  @override
  // ignore: library_private_types_in_public_api
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  late bool check;
  

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
          "Ajouter un cours",
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/image.png',
                width: 250,
                height: 300,
              ),
              const SizedBox(height: 20),
              const Text(
                "Vous pouvez ajouter des cours, devoirs aux étudiants ici",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Coursinfo(fullName: widget.fullName)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 2, 78, 140),
                ),
                child: const Text(
                  "Ajouter Cour",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10), // Added SizedBox for spacing
              ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> courseInfo = await DatabaseHelper().getCoursInfo(widget.fullName);
                  if (courseInfo.isNotEmpty) {
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(builder: (context) => Pagecours(courseInfo: courseInfo)),
                    );
                  } else {
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(builder: (context) => const Pagenocours()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 2, 78, 140),
                ),
                child: const Text(
                  "Voir tous les cours",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
