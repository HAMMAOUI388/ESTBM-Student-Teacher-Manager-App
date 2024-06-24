import 'package:flutter/material.dart';

class Pageavis extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const Pageavis({super.key, required this.messages});

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
          "Avis de vos professeurs",
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
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 255, 152, 0),
                        ),
                      ),
                      Text(
                        "  From Pr. ${messages[index]['username']} ",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 255, 152, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  subtitle: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: 100,
                      height: 80,
                      color: const Color.fromARGB(255, 238, 238, 240),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sujet: ${messages[index]['subject']}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${messages[index]['message']}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
