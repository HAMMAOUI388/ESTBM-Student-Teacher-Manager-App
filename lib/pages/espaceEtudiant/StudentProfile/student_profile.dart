import 'package:flutter/material.dart';

class ProfiletudiantePage extends StatelessWidget {
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

  const ProfiletudiantePage({
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
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
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: const Center(
                  child: Text(
                    'Ecole Supérieure de Technologie Beni Mellal',
                    style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 2, 78, 140), fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.86,
                height: MediaQuery.of(context).size.height * 0.63,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 4),
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('lib/images/enseignants.jpeg'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Informations Professionnelles',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color.fromARGB(255, 255, 152, 0)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      fullName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Vérifiez vos informations pour chaque erreur.',
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'N\'hésitez pas à contacter le service Scolarité.',
                    ),
                    const SizedBox(height: 15),
                    _buildListItems('Apogee : ',' $userApogee',  Icons.account_circle,  const Color.fromARGB(255, 2, 78, 140) ),
                    _buildListItems(  'Cne : ',' $userCne', Icons.qr_code, const Color.fromARGB(255, 2, 78, 140)),
                    _buildListItems('CIN: ',' $userCin', Icons.perm_identity,const Color.fromARGB(255, 2, 78, 140) ),
                    _buildListItem('Nom :',' $userName', Icons.person, const Color.fromARGB(255, 2, 78, 140),'          En Arabe: ',' $userNomarabe'),
                    _buildListItem('Prenom :',' $userPrename', Icons.person, const Color.fromARGB(255, 2, 78, 140),'        En Arabe: ',' $userPrenomarabe'),
                    _buildListItems('Date de naissance: ', '  $userDateNaissance ', Icons.date_range,const Color.fromARGB(255, 2, 78, 140)),                   
                    _buildListItems('filiere: ',' $userFiliere', Icons.category,const Color.fromARGB(255, 2, 78, 140)),
                    _buildListItems('Lieu de naissance : ',' $userLieuNaissance', Icons.place,const Color.fromARGB(255, 2, 78, 140)),
                    _buildListItems('Lieu de naissance(en Arabe) : ',' $userLieuNaissancearabe', Icons.place,const Color.fromARGB(255, 2, 78, 140)),
                  ],                  
                ),
              ),
                const Spacer(), // To push the footer text to the bottom
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

 
  
   Widget _buildListItems(String text1,String text2, IconData icon1, Color iconColor) {
  return Row(
    children: [
      Expanded(
  child: Row(
    children: [
      Icon(
        icon1,
        color: iconColor,
        size :15,
      ),
      const SizedBox(width: 20),
      Text(
        text1,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 0, 0, 0)),
      ),
      
      Text(
        text2,
        style: const TextStyle(fontSize: 13,),
      ),
    ],
  ),
),
      const SizedBox(height: 25),

   const Divider(height: 8, color: Colors.grey),

    ],
  );
}

 Widget _buildListItem(String text1,String text2, IconData icon1, Color iconColor, String text3, String text4) {
  return Row(
    children: [
      Expanded(
  child: Row(
    children: [
      Icon(
        icon1,
        color: iconColor,
        size :15,
      ),
      const SizedBox(width: 20),
      Text(
        text1,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 7, 7, 7)),
      ),
      
      Text(
        text2,
        style: const TextStyle(fontSize: 13,),
      ),
       Text(
        text3,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 7, 7, 7)),
      ),
       Text(
        text4,
        style: const TextStyle(fontSize: 13,),
      ),
    ],
  ),
),
      const SizedBox(height: 25),

       const Divider(height: 8,color: Colors.grey,),
    ],
  );
} 
}
