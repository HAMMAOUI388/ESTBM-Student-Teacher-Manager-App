import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

class ExternalCourse {
  final String name;
  final String url;
  final String rating;
  final String difficulty;
  final List<String> tags;

  ExternalCourse({
    required this.name,
    required this.url,
    required this.rating,
    required this.difficulty,
    required this.tags,
  });

  factory ExternalCourse.fromJson(Map<String, dynamic> json) {
    // Decode the JSON array from the 'Tags' field
    List<String> tags = [];
    if (json['Tags'] != null) {
      tags = List<String>.from(jsonDecode(json['Tags']));
    }

    return ExternalCourse(
      name: json['Name'],
      url: json['URL'],
      rating: json['Rating'],
      difficulty: json['Dificulty'],
      tags: tags,
    );
  }
}

class ExternalCoursesPage extends StatefulWidget {
  const ExternalCoursesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExternalCoursesPageState createState() => _ExternalCoursesPageState();
}

class _ExternalCoursesPageState extends State<ExternalCoursesPage> {
  List<ExternalCourse> _externalCourses = [];
  List<ExternalCourse> _filteredCourses = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadExternalCourses();
  }

  Future<void> _loadExternalCourses() async {
    try {
      String jsonString = await rootBundle.loadString('assets/coursera-course-detail-data.json');
      List<dynamic> jsonList = json.decode(jsonString);
      List<ExternalCourse> courses = jsonList.map((e) => ExternalCourse.fromJson(e)).toList();
      setState(() {
        _externalCourses = courses;
        _filteredCourses = courses;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading external courses: $e');
      }
    }
  }

  void _handleSearch(String query) {
    List<ExternalCourse> filteredCourses = _externalCourses.where((course) {
      return course.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredCourses = filteredCourses;
    });
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('External Courses'),
        backgroundColor: Colors.orange ,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/patt.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search for courses...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _handleSearch(value);
                  },
                ),
              ),
              Expanded(
                child: _filteredCourses.isNotEmpty
                    ? ListView.builder(
                        itemCount: _filteredCourses.length,
                        itemBuilder: (context, index) {
                          ExternalCourse course = _filteredCourses[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            color: const Color.fromARGB(255, 33, 43, 48),
                            child: GestureDetector(
                              onTap: () {
                                _launchURL(course.url);
                              },
                              child: ListTile(
                                title: Text(
                                  course.name,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rating: ${course.rating}',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      'Difficulty: ${course.difficulty}',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      'Tags: ${course.tags}',
                                      style:const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}