import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_application_1/pages/espaceEnseignant/about.dart';
import 'package:flutter_application_1/pages/espaceEnseignant/aide.dart';
import 'package:flutter_application_1/pages/espaceEnseignant/contact.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/StudentProfile/student_profile.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/avisetudiant.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/calendart.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/chatGroupe/additional_info_screen.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/chatbot/chat_bot_consultation.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/courextern/cour_extern.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/cours/screens/coursetudiant.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/cours/screens/pageempty.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/meeting/meeting_room.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/pasdavis.dart';
import 'package:flutter_application_1/pages/etudiant.dart';


class EspaceEtudiantPage extends StatelessWidget {

  final String userApogee;
  final String userName;
  final String userPrename;
  final String userDateNaissance;
  final String userCne;
  final String userCin;
  final String userFiliere;
  final String userLieuNaissance;
  final String userNomarabe;
  final String userPrenomarabe;
  final String userLieuNaissancearabe;
  String get fullName => '$userName $userPrename';
  const EspaceEtudiantPage({
  super.key,
required this.userApogee,
required this.userName,
required this.userPrename,
required this.userDateNaissance,
required this.userCne,
required this.userCin,
required this.userFiliere,
required this.userLieuNaissance,
required this.userNomarabe,
required this.userPrenomarabe,
required this.userLieuNaissancearabe,
  });
  @override
  Widget build(BuildContext context) {
    String studentName = '$userName $userPrename';
    // ignore: no_leading_underscores_for_local_identifiers
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.person_outline_outlined, size: 28),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            Expanded(
              child: Center(
                child: Text(studentName),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chat_outlined),
             onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdditionalInfoForm()));
              },            
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
      ),
         

      drawer: Drawer(
       child: Container(
         decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/patt.png'), 
           fit: BoxFit.cover,
      ),
       ),
        
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 2, 78, 140),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('lib/images/enseignants.jpeg'),
                    radius: 30,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon (
                Icons.person ,
                color:Color.fromARGB(255, 2, 78, 140) ,
                ),
              title: const Text(
                'Profil' ,
                style: TextStyle(
            fontSize: 14,
    ),
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfiletudiantePage(
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
              },
            ),
             ListTile(
               leading: const Icon(Icons.notifications,color:Color.fromARGB(255, 2, 78, 140)),
        title: const Text(
          'Consultez les avis de vos prof',
           style: TextStyle(
             fontSize: 14,
    ),
          ),
        onTap: () async {
  // Call the method to get messages
  List<Map<String, dynamic>> messages = await DatabaseHelper().getMessagesbyfiliere(userFiliere);
  
  // Check if the messages list is empty
  if (messages.isEmpty) {
    // If the messages list is empty, navigate to Pageempty.dart
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const Pagepasavis()),
    );
  } else {
    // If the messages list is not empty, navigate to Pageavis.dart and pass the messages as arguments
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => Pageavis(messages: messages),
      ),
    );
  }
},

      ),
      ListTile(
        leading: const Icon(Icons.chat  ,color:Color.fromARGB(255, 2, 78, 140)),
        title: const Text(
          'Chat groupe',
           style: TextStyle(
             fontSize: 14,
    ),
        ),
        
        onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdditionalInfoForm()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.import_contacts, color: Color.fromARGB(255, 2, 78, 140)),

        title: const Text(
          'Cours Externs',
           style: TextStyle(
             fontSize: 14,
    ),
          ),
        onTap: () {
Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExternalCoursesPage()),
    );


          // Add onTap function if needed
        },
      ),
      ListTile(
                leading: const Icon(Icons.book, color: Color.fromARGB(255, 2, 78, 140)),

        title: const Text(
          'Cours ',
           style: TextStyle(
             fontSize: 14,
    ),
        ),
        onTap: () async {
    // Call the method to get course information by filiere
    List<Map<String, dynamic>> coursInfo = await DatabaseHelper().getCoursInfoByfiliere(userFiliere);
    
    // Check if the data is empty
    if (coursInfo.isEmpty) {
      // If data is empty, navigate to Pageempty.dart
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const Pageempty()),
      );
    } else {
      // If data is not empty, navigate to courseetudiant.dart and pass the information
     Navigator.push(
  // ignore: use_build_context_synchronously
  context,
  MaterialPageRoute(
    builder: (context) => CourseEtudiant(
      courseInfo: coursInfo, // Pass the required argument here
    ),
  ),
);
    }
  },
      ),
      ListTile(
         leading: const Icon(Icons.chat_bubble, color: Color.fromARGB(255, 2, 78, 140)),
        title: const Text(
          'Chat bot',
           style: TextStyle(
             fontSize: 14,
    ),
    ),
        onTap: () {
           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatBot(),
                  ),
                );
        },
      ),
 ListTile(
         leading: const Icon(Icons.contact_phone, color: Color.fromARGB(255, 2, 78, 140)),
        title: const Text(
          'Contacter le service scolarité ',
           style: TextStyle(
             fontSize: 14,
    ),
    ),
        onTap: () {
           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactPage(),
                  ),
                );
        },
      ),
      ListTile(
         leading: const Icon(Icons.video_call, color: Color.fromARGB(255, 2, 78, 140)),
        title: const Text(
          'Rejoindre une réunion en ligne',
           style: TextStyle(
             fontSize: 14,
    ),
    ),
        onTap: () {

          
           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MeetingRoomScreen(),
                  ),
                );
        },
      ),
 const Divider(color: Color.fromARGB(255, 172, 163, 166)), // Divider with pink color

    Container(
      color: const Color.fromARGB(255, 255, 254, 254), // Background color
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.help, color: Color.fromARGB(255, 2, 78, 140)),
            title: const Text(
              'Aide',
               style: TextStyle(
             fontSize: 14,
             ),
              ),
             onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AidePage(),
                  ),
                );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help,color: Color.fromARGB(255, 2, 78, 140)),
            title: const Text(
              'à propos',
                 style: TextStyle(
             fontSize: 14,
    ),
    ),
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app ,color: Color.fromARGB(255, 2, 78, 140)),
            title: const Text(
              'Déconnexion',
                 style: TextStyle(
             fontSize: 14,
    ),
              ),
            onTap: () {
             _logout(context);
            },
          ),
        ],
      ),
    ),
          ],
        ),
      ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/pngg.png',
                  width: 250,
                  height:250,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Bienvenue sur votre espace personnel! Ici,\n vous trouverez de nombreuses fonctionnalités pour améliorer votre expérience. \n ",
                  
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
         Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PageCalendrier(),
                  ),
                );
              },
            ),
             IconButton(
              icon: const Icon(Icons.video_call_outlined,size: 30 ,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MeetingRoomScreen()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
             onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => const  ChatBot()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.import_contacts),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=> const ExternalCoursesPage()));
              },
            ),
         IconButton(
  icon: const Icon(Icons.class_outlined),
  onPressed: () async {
    // Call the method to get course information by filiere
    List<Map<String, dynamic>> coursInfo = await DatabaseHelper().getCoursInfoByfiliere(userFiliere);
    
    // Check if the data is empty
    if (coursInfo.isEmpty) {
      // If data is empty, navigate to Pageempty.dart
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const Pageempty()),
      );
    } else {
      // If data is not empty, navigate to courseetudiant.dart and pass the information
     Navigator.push(
  // ignore: use_build_context_synchronously
  context,
  MaterialPageRoute(
    builder: (context) => CourseEtudiant(
      courseInfo: coursInfo, // Pass the required argument here
    ),
  ),
);
    }
  },
),
          ],
        ),
      ),
    );
  }
  // ignore: unused_element
  Widget _buildNotificationSection(String title, List<FeedItem> notifications) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notifications[index].title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notifications[index].description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
void _logout(BuildContext context) {
  AuthManager.logout();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) =>  EtudiantPage()),
    (route) => false, 
  );
}
class AuthManager {
  static bool isLoggedIn = false;
  static void login() {
    isLoggedIn = true;
  }
  static void logout() {
    isLoggedIn = false;
  }
}

class FeedItem {
  final String title;
  final String description;

  FeedItem(this.title, this.description);
}

List<FeedItem> externalCoursesNotifications = [
  FeedItem('New External Course Available!', 'Learn advanced programming with Dart and Flutter on Coursera.'),
 
];

List<FeedItem> schoolAdminNotifications = [
  FeedItem('Message from School Administration', 'Reminder: Assignment #2 is due next Friday.'),
  
];

List<FeedItem> classScheduleNotifications = [
  FeedItem('New Class Schedule Available!', 'Your class schedule for the next semester has been updated.'),
  
];
