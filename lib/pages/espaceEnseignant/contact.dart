import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacter le service scolarité',
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
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: const Text(
                    'Contact',
                    style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 152, 0), fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'lib/images/logo.png',
                  width: 104, 
                  height: 104,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ecole Supérieure de Technologie Beni Mellal',
                  style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 2, 78, 140), fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 25),
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.phone, color: Colors.black), 
                          SizedBox(width: 5),
                          Text(
                            'Tél:',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                         
                           Text(
                            ' +212(0)5234-84168',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.email, color: Colors.black), 
                          SizedBox(width: 5),
                          Text(
                            'E-mail: ',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            'est@usms.ma',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.contact_phone_outlined, color: Colors.black), 
                          SizedBox(width: 5),
                          Text(
                            'Fax:',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            ' 05 23 48 17 72',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.location_city, color: Colors.black), 
                          SizedBox(width: 5),
                          Text(
                            'Adresse: Campus universitaire ',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                       SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Text(
                            ' M\'ghila BP:591, Béni Mellal 23000',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.public, color: Colors.black), 
                          SizedBox(width: 5),
                          Text(
                            'Site Web: ',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                           Text(
                            'estbm.ac.ma',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(), // To push the footer text to the bottom
                const Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Text(
                    '2024 © ESTBM . All Rights Reserved\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF193650),
                      fontWeight: FontWeight.w600,
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
