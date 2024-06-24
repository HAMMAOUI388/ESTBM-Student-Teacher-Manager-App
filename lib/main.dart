import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_etudiant_insert.dart';
import 'package:flutter_application_1/database/insert_enseignants.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_application_1/pages/enseignant.dart';
import 'package:flutter_application_1/pages/etudiant.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    handleMessage(message);
  });

  await DatabaseHelper().initEtudiantDatabase();
  await insertEtudiants();

  await insertEnseignants();






  runApp(const MyApp(initialRoute: HomePageWidget()));
}


void handleMessage(RemoteMessage message) {
  if (message.notification != null) {
    displayNotification(message.notification!);
  }

  if (message.data.isNotEmpty) {
    processDataMessage(message.data);
  }
}


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void displayNotification(RemoteNotification notification) async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_notification');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: null);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // ignore: prefer_const_declarations
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
          'your channel id', 'your channel name',
          importance: Importance.max, priority: Priority.high);
  final NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    notification.title,
    notification.body,
    platformChannelSpecifics,
  );
}

void processDataMessage(Map<String, dynamic> data) {
}

// Background message handling
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ignore: avoid_print
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  // ignore: use_super_parameters
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESTBM App',
      home: const HomePageWidget(),
      routes: {
        '/etudiant': (context) => EtudiantPage(),
        '/enseignant': (context) => const EnseignantPage(),

      },
    );
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'ESTBM',
            style: TextStyle(
              color: Color(0xFF193650),
              fontFamily: 'Readex Pro',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Ecole Supérieure de Technologie Beni Mellal ',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF193650),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Image.asset(
                          'lib/images/logo.png',
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/etudiant');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 152, 0),
                            elevation: 3,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 30,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(150, 0),
                          ),
                          child: const Text(
                            'Étudiant',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/enseignant');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 152, 0),
                            elevation: 3,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 30,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(150, 0),
                          ),
                          child: const Text(
                            'Enseignant',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                      Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '2024 © ESTBM . All Rights Reserved\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF193650),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
