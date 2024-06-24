// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/espaceEnseignant/about.dart';
import 'package:flutter_application_1/pages/espaceEnseignant/aide.dart';
import 'package:flutter_application_1/pages/espaceEnseignant/contact.dart';
import 'package:flutter_application_1/pages/enseignant.dart';
import 'package:flutter_application_1/pages/espaceEnseignant/envoieavis.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/calendart.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/cours/screens/addcours.dart';
import 'package:flutter_application_1/pages/espaceEnseignant/profileenseignant.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/meeting/meeting_room.dart';





class EspacEnseignantPage extends StatelessWidget {
  final String userName;
  final String userPrename;
  final String userId;
  final String userCin;
  final String userEmail;
  final String userMatricule;
  final String userDateNaissance;

  final String userLieuNaissance;
  final String userNomarabe;
  final String userPrenomarabe;
  final String userLieuNaissancearabe;


  String get fullName => '$userName $userPrename';

  const EspacEnseignantPage({
    super.key,
    required this.userName,
    required this.userPrename,
    required this.userCin,
    required this.userId,
    required this.userEmail,
    required this.userMatricule,
    required this.userDateNaissance,
    required this.userLieuNaissance,
    required this.userNomarabe,
    required this.userPrenomarabe,
    required this.userLieuNaissancearabe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('      '),
            const SizedBox(width: 15),
            Text(
              fullName,
              textAlign: TextAlign.right,
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
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
                    fullName,
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
                    builder: (context) => ProfilPage(
                      userName: userName,
                      userPrename: userPrename,
                      userId: userId,
                      userCin: userCin,
                      userEmail: userEmail,
                      userDateNaissance: userDateNaissance,
                      userMatricule: userMatricule,
                      userLieuNaissance: userLieuNaissance,
                      userNomarabe: userNomarabe, 
                      userPrenomarabe: userPrenomarabe ,
                      userLieuNaissancearabe: userLieuNaissancearabe , 

                    ),
                  ),
                );
              },
            ),
            
      
      ListTile(
        leading: const Icon(Icons.book, color: Color.fromARGB(255, 2, 78, 140)),

        title: const Text(
          'ajouter  des Cours aux  étudiants ',
           style: TextStyle(
             fontSize: 14,
    ),
          ),
         onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCoursePage(
                      fullName: fullName,
                     
                    ),
                  ),
                );
              },
      ),
     
      ListTile(
         leading: const Icon(Icons.contact_support, color: Color.fromARGB(255, 2, 78, 140)),
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
         leading: const Icon(Icons.send, color: Color.fromARGB(255, 2, 78, 140)),
        title: const Text(
          'Envoyer des avis aux étudiants ',
           style: TextStyle(
             fontSize: 14,
    ),
    ),
        onTap: () {
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  EnvoiavisPage(fullName:fullName),
        )
       );
        },
      ),
       
          ListTile(
         leading: const Icon(Icons.video_call,  color: Color.fromARGB(255, 2, 78, 140)),
        title: const Text(
          ' Réunion vidéo en ligne ',
           style: TextStyle(
             fontSize: 14,
            ),
          ),
        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MeetingRoomScreen()));

        },
      ),

 ListTile(
         leading: const Icon(Icons.calendar_today,  color: Color.fromARGB(255, 2, 78, 140)),
        title: const Text(
          ' Calendar ',
           style: TextStyle(
             fontSize: 14,
            ),
          ),
         onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PageCalendrier(),
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
      body:Stack(
        children: [
          Image.asset(
            'lib/images/patt.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                const SizedBox(width: 20),
                _buildSquareButton( Icons.video_call , 'Réunion vidéo en ligne', isButton: true,
                  onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MeetingRoomScreen()));

                          },
                          ),
                  ],
                ),
                const SizedBox(height: 30),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                const SizedBox(width: 20),
                  _buildSquareButton( Icons.book , 'ajouter des  Cours aux étudiants ', isButton: true,
                onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCoursePage(
                      fullName: fullName,
                    ),
                  ),
                );
              },
              ), 
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                 const SizedBox(width: 20),
       _buildSquareButton( Icons.send , 'Envoyer des Avis aux étudiants', isButton: true,
           onTap: () {
         Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  EnvoiavisPage(fullName:fullName),
        )

       );
      },
    ), 
                  ],
                ),


              const SizedBox(height: 30),


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                                     const SizedBox(width: 20),

                _buildSquareButton( Icons.contact_support, 'Contacter le service scolarité', isButton: true,
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => const ContactPage(),
             ),
             );
              },
             ), 
              ],
                ),


              ],
            ),
          ),
        ],
      ),
    
      bottomNavigationBar: BottomAppBar(
        color:  const Color.fromARGB(255, 255, 255, 255),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               GestureDetector(
          onTap: () {
            // Handle onTap event for the home icon
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.3), // Grey transparent color
            child: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 2, 78, 140),
            ),
          ),
        ),
              IconButton(
                icon: const Icon(Icons.account_circle, color:   Color.fromARGB(255, 2, 78, 140)),
                onPressed: () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilPage(
                      userName: userName,
                      userPrename: userPrename,
                      userId: userId,
                      userCin: userCin,
                      userEmail: userEmail,
                      userDateNaissance: userDateNaissance,
                      userMatricule: userMatricule,
                      userLieuNaissance: userLieuNaissance,
                      userNomarabe: userNomarabe, 
                      userPrenomarabe: userPrenomarabe ,
                      userLieuNaissancearabe: userLieuNaissancearabe , 

                    ),
                  ),
                );
                },
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today, color:   Color.fromARGB(255, 2, 78, 140)),
                onPressed: () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PageCalendrier(),
                  ),
                );
                },
              ),
            ],
          ),
        ),
      ),
    );
    }
    }
 void _logout(BuildContext context) {
  AuthManager.logout();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const EnseignantPage()),
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
 Widget _buildSquareButton(IconData icon, String label, {bool isButton = false, Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 360, // Adjust width as per your requirement
      height: 130, // Adjust height as per your requirement
      decoration: BoxDecoration(
        color: isButton ? const Color.fromARGB(255, 252, 245, 234) : Colors.transparent,
        borderRadius: BorderRadius.circular(16), // Adjust border radius as per your requirement
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Icon(icon, size: 36, color: const Color.fromARGB(255, 2, 78, 140)),
          const SizedBox(width: 8), // Adjust the space between icon and text
          const SizedBox(width: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 12), // Adjust font size as per your requirement
          ),
          const SizedBox(width: 17),

          const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey), // Icon for scrolling to the next item
        ],
      ),
    ),
  );
}

