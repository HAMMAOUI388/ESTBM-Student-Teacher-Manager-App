import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'A propos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
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
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 11),
                child: const Center(
                  child: Text(
                    'Ecole Supérieure de Technologie Beni Mellal',
                    style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 2, 78, 140), fontWeight: FontWeight.w800),
                  ),
                ),
              ),
               const Text(
                'Application ESTBM Mobile',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              const Text(
                'Développé par :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('LAYLA OUYOUSSEF'),
              const SizedBox(height: 7),
              const Text('FATIMA EZZAHRAE HAMMAOUI'),
              const Spacer(),
              TextButton(
                onPressed: () {
                  _launchURL('https://estbm.ac.ma/');
                },
                style: ButtonStyle(
    overlayColor: MaterialStateProperty.all(const Color.fromARGB(0, 202, 200, 200)), // Remove overlay color
  ),
                child: const Text(
                  'estbm.ac.ma',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              '2024 © ESTBM . All Rights Reserved\n',
               textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF193650),
                      fontWeight: FontWeight.w600,
                    )
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
