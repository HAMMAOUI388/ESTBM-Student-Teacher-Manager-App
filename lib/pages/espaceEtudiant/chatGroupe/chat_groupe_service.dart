import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/database_helper.dart';


class ChatGroupService {



  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;


static Future<void> sendMessage(String chatGroupId, String messageText, String appogee, String cne) async {
  // Fetch sender's name from the database using DatabaseHelper
  Map<String, dynamic>? senderInfo = await DatabaseHelper().getStudentInfo(appogee, cne);
  if (senderInfo != null) {
    String senderName = '${senderInfo['nom']} ${senderInfo['prenom']}';

    // Send the message to Firestore
    await _firestore
        .collection('EST-groupes')
        .doc(chatGroupId)
        .collection('messages')
        .add({
      'text': messageText,
      'sender': senderName,
      'senderName': senderName,
      'timestamp': FieldValue.serverTimestamp(),
      'appogee': appogee,
      'cne': cne,
    });
  }
}




  // Method to retrieve messages from a chat group
  static Stream<QuerySnapshot> getMessages(String chatGroupId) {
    return _firestore
        .collection('EST-groupes')
        .doc(chatGroupId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Method to fetch chat groups for a student
  static Future<List<QueryDocumentSnapshot>> getChatGroupsForStudent(String filiere, int anneeScolaire) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('EST-groupes')
        .where('Filiere', isEqualTo: filiere)
        .where('AnneeScolaire', isEqualTo: anneeScolaire)
        .get();

    return querySnapshot.docs;
  }

}
