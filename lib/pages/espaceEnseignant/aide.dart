import 'package:flutter/material.dart';

class AidePage extends StatelessWidget {
  const AidePage({super.key});

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
          "Aide",
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bienvenue à l\'Aide',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 2, 78, 140)),
                
                ),
                const SizedBox(height: 25,),
                 const Text(
                ' École Supérieure de Technologie Beni Mellal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 2, 78, 140)),
                
                ), 
            const SizedBox(height: 25,),
              const Text(
                'Comment Utiliser l\'Application:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSectionForEnseignants(),
              const SizedBox(height: 20),
              _buildSectionForEtudiants(),
              const SizedBox(height: 20),
              _buildFAQ(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionForEnseignants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pour les Enseignants:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 255, 152, 0)),
        ),
        _buildInstruction("Ajouter des Cours:", [
          "Cliquez sur le bouton \"Ajouter un Cours\".",
          "Remplissez les détails du cours, y compris le titre, la filiere et les documents associés.",
         
          "Cliquez sur \"Ajouter\" pour publier le cours pour les étudiants.",
        ]),
        _buildInstruction("Envoyer des Avis:", [
          "Accédez à la section \"Avis\".",
         
          "Rédigez votre message et sélectionnez les destinataires.",
          "Cliquez sur \"Envoyer\" pour publier l'avis aux étudiants.",
        ]),
        _buildInstruction("Créer des Réunions en Ligne:", [
          "Accédez à la section \"Réunions\".",
          "Cliquez sur \"Nouvelle Réunion\".",
          "Configurez les détails de la réunion, y compris la date, l'heure et les participants.",
          "Partagez le lien de la réunion avec les étudiants.",
        ]),
      ],
    );
  }

  Widget _buildSectionForEtudiants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pour les Étudiants:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 255, 152, 0)),
        ),
        _buildInstruction("Consulter les Cours:", [
          "Accédez à la section \"Cours\".",
          "Parcourez la liste des cours disponibles.",
          "Cliquez sur un cours pour afficher les détails et télécharger les documents associés.",
        ]),
        _buildInstruction("Consulter les Avis:", [
          "Accédez à la section \"Avis\".",
          "Consultez les avis publiés par les enseignants concernant les cours, les examens, etc.",
          "Restez informé des annonces importantes concernant votre programme d'études.",
        ]),
        _buildInstruction("Participer aux Réunions en Ligne:", [
          "Accédez à la section \"Réunions\".",
          "Cliquez sur le lien de la réunion planifiée.",
          "Rejoignez la réunion en ligne et participez aux discussions avec vos enseignants et camarades de classe.",
        ]),
         _buildInstruction("Accéder aux Cours Externes:", [
        "Consultez les cours externes disponibles.",
        "Accédez aux ressources en ligne pour enrichir votre apprentissage.",
      ]),
      _buildInstruction("Chatgroup avec vos camarades de classe:", [
        "Rejoignez les groupes de discussion avec vos camarades de classe.",
        "Partagez des informations, posez des questions et collaborez sur des projets.",
      ]),
      _buildInstruction("Chat Robot pour de l'aide:", [
        "Utilisez le chatbot pour obtenir de l'aide instantanée sur des sujets spécifiques.",
        "Posez des questions et recevez des réponses automatisées.",
      ]),
      ],
    );
  }

  Widget _buildInstruction(String title, List<String> steps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: steps.map((step) => _buildStep(step)).toList(),
        ),
      ],
    );
  }

  Widget _buildStep(String step) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        '• $step',
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildFAQ() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Foire Aux Questions (FAQ):',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 255, 152, 0)),
        ),
_buildQuestionAnswer("Q: Comment puis-je télécharger les documents de cours?", "R: Pour télécharger les documents de cours, cliquez sur le cours souhaité dans la section \"Cours\", puis cliquez sur l'icône de téléchargement à droite du chemin du fichier sur la page de détails du cours."),
        _buildQuestionAnswer("Q: Comment puis-je contacter le support technique en cas de problème?", "R: Vous pouvez contacter le service scolarite."),
      ],
    );
  }
  Widget _buildQuestionAnswer(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          answer,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

