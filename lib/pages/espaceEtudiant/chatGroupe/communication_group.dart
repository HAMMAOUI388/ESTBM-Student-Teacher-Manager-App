
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';



String formatTime(DateTime time) {
  return DateFormat('HH:mm').format(time);
}

class Message {
  final String id;
  final String content;
  final String senderId;
  final String senderName;
  final DateTime timestamp;
  final String appogee;
  final String cne;
  final String? fileUrl;
  final String? fileType; // Add this field

  Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
    required this.appogee,
    required this.cne,
    this.fileUrl,
    this.fileType, // Initialize this field
  });
}




class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isSentByCurrentUser;
  final VoidCallback onDeletePressed;
  final List<QueryDocumentSnapshot> chatGroupId;
  final Key? key;

  const MessageBubble({
    this.key,
    required this.message,
    required this.isSentByCurrentUser,
    required this.onDeletePressed,
    required this.chatGroupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showMessageOptions(context, message, isSentByCurrentUser, chatGroupId),
      child: Align(
        alignment: isSentByCurrentUser ? Alignment.centerLeft : Alignment.centerRight,
        child: _messageBubble(message, context),
      ),
    );
  }



Widget _messageBubble(Message message, BuildContext context) {
  return Row(
    mainAxisAlignment: isSentByCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      Flexible(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .04, vertical: MediaQuery.of(context).size.height * .01),
          decoration: BoxDecoration(
            color: isSentByCurrentUser ? Colors.blueGrey : const Color.fromARGB(255, 33, 43, 48),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isSentByCurrentUser ? 30 : 0),
              topRight: Radius.circular(isSentByCurrentUser ? 0 : 30),
              bottomLeft: const Radius.circular(30),
              bottomRight: const Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isSentByCurrentUser) // Display sender's name only for messages sent by other users
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.5, top: 3.0, bottom: 5.0),
                  child: Text(
                    message.senderName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange[800],
                    ),
                  ),
                ),
              Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
                child: _buildMessageContent(message),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

  Widget _buildMessageContent(Message message) {
    if (message.fileUrl != null) {
      return _buildFileMessage(message);
    } else {
      return _buildTextMessage(message);
    }
  }

Widget _buildTextMessage(Message message) {
  return Text(
    message.content,
    style: TextStyle(
      fontSize: 15,
      color: isSentByCurrentUser ? Colors.black : Colors.white,
    ),
  );
}


Widget _buildFileMessage(Message message) {
  return GestureDetector(
    onTap: () => _openFile(message.fileUrl!),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue, // Customize color for file message bubble
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'File: ${message.content}', // Display file name
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Row(
            children: [
              Icon(
                Icons.attach_file,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 5),
              Text(
                'File',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}








void _openFile(String url) async {
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}




  // Add _showMessageOptions method here
  void _showMessageOptions(BuildContext context, Message message, bool isSentByCurrentUser, List<QueryDocumentSnapshot> chatGroupId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Message Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Content: ${message.content}'),
              const SizedBox(height: 8),
              Text('Sender: ${message.senderName}'),
              const SizedBox(height: 8),
              Text('Timestamp: ${message.timestamp}'),
            ],
          ),
          actions: [
            if (isSentByCurrentUser)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showMessageUpdateDialog(context, message, isSentByCurrentUser, chatGroupId);
                },
                child: const Text('Update'),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteMessage(message.id, chatGroupId); // Call the delete callback
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Add _showMessageUpdateDialog method here
  void _showMessageUpdateDialog(BuildContext context, Message message, bool isSentByCurrentUser, List<QueryDocumentSnapshot> chatGroupId) {
    String updatedMsg = message.content;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Row(
          children: [
            Icon(
              Icons.message,
              color: Colors.blue,
              size: 28,
            ),
            Text(' Update Message')
          ],
        ),
        content: TextFormField(
          initialValue: updatedMsg,
          maxLines: null,
          onChanged: (value) => updatedMsg = value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              _updateMessage(updatedMsg, message.id, chatGroupId);
            },
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

void _updateMessage(String updatedMsg, String messageId, List<QueryDocumentSnapshot> chatGroupId) {
  FirebaseFirestore.instance
    .collection('EST-groupes')
    .doc(chatGroupId.isNotEmpty ? chatGroupId[0].id : null)
    .collection('messages')
    .doc(messageId)
    .update({
      'content': updatedMsg,
    }).then((_) {
      // Update successful
      if (kDebugMode) {
        print('Message updated successfully');
      }
    }).catchError((error) {
      // Handle errors
      if (kDebugMode) {
        print('Failed to update message: $error');
      }
    });
}

// In _deleteMessage and _updateMessage methods
void _deleteMessage(String messageId, List<QueryDocumentSnapshot> chatGroupId) {
  FirebaseFirestore.instance
    .collection('EST-groupes')
    .doc(chatGroupId.isNotEmpty ? chatGroupId[0].id : null)
    .collection('messages')
    .doc(messageId)
    .delete()
    .then((_) {
      // Deletion successful
      if (kDebugMode) {
        print('Message deleted successfully');
      }
    })
    .catchError((error) {
      // Handle errors
      if (kDebugMode) {
        print('Failed to delete message: $error');
      }
    });
}



}



class CommunicationGroupPage extends StatefulWidget {
  final String cne;
  final String appogee;
  final String filiere;
  final int anneeScolaire;
  final List<QueryDocumentSnapshot> chatGroupId;
  final String senderName; // Add senderName parameter

  const CommunicationGroupPage({
    required this.cne,
    required this.appogee,
    required this.filiere,
    required this.anneeScolaire,
    required this.chatGroupId,
    required this.senderName, // Include senderName parameter
    super.key, // Add key parameter
  }); // Call super constructor with key parameter

  @override
  // ignore: library_private_types_in_public_api
  _CommunicationGroupPageState createState() => _CommunicationGroupPageState();
}



class _CommunicationGroupPageState extends State<CommunicationGroupPage> {
  final TextEditingController _messageController = TextEditingController();
  bool _isSendingMessage = false;
  late FlutterSoundRecorder _audioRecorder;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication Group'),
        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
      ),
      body: Stack(
        children: [
          Image.asset(
            'lib/images/pattdark.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Expanded(
                child: _buildChatInterface(context),
              ),
              _buildChatInput(context),
            ],
          ),
        ],
      ),
    );
  }


Widget _buildChatInterface(BuildContext context) {
  return StreamBuilder(
    stream: _getChatMessagesStream(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Center(child: Text('Say Hi! 👋'));
      }
      final List<Message> messages = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Message(
          id: doc.id,
          content: data['content'] ?? '',
          senderId: data['sender'] ?? '',
          senderName: data['senderName'] ?? '',
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          appogee: data['appogee'] ?? '',
          cne: data['cne'] ?? '',
        );
      }).toList();

      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return ListView.builder(
        reverse: false,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isSentByCurrentUser = message.senderId == widget.cne; // Correct check
          return MessageBubble(
            message: message,
            isSentByCurrentUser: isSentByCurrentUser,
            onDeletePressed: () => _deleteMessage(message.id),
            chatGroupId: widget.chatGroupId,
          );
        },
      );
    },
  );
}


  Stream<QuerySnapshot> _getChatMessagesStream() {
    if (widget.chatGroupId.isEmpty) {
      return FirebaseFirestore.instance.collection('EST-groupes').doc().collection('messages').orderBy('timestamp').snapshots();
    } else {
      return FirebaseFirestore.instance.collection('EST-groupes').doc(widget.chatGroupId[0].id).collection('messages').orderBy('timestamp').snapshots();
    }
  }





Widget _buildChatInput(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    color: Colors.grey[200],
    child: Row(
      children: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  _messageController.text += emoji.emoji;
                },
              ),
            );
          },
          icon: const Icon(Icons.emoji_emotions),
        ),
        Expanded(
          child: GestureDetector(
            onTapDown: (_) {
              _startRecordingVoiceMessage();
            },
            onTapUp: (_) {
              _stopRecordingVoiceMessage();
            },
            onTapCancel: () {
              _stopRecordingVoiceMessage();
            },
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onTap: () {
                setState(() {
                  _isSendingMessage = true;
                });
              },
              onChanged: (text) {
                setState(() {
                  _isSendingMessage = text.isNotEmpty;
                });
              },
              onSubmitted: (_) {
                if (_isSendingMessage) {
                  _sendMessage(context);
                } else {
                  _startRecordingVoiceMessage();
                }
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              PlatformFile file = result.files.first;
              // ignore: use_build_context_synchronously
              _sendFileMessage(context, file);
            }
          },
          icon: const Icon(Icons.attach_file),
        ),
        IconButton(
          onPressed: () {
            _sendMessage(context);
            _messageController.clear(); // Clear the message
          },
          icon: _isSendingMessage ? const Icon(Icons.send) : const Icon(Icons.mic),
        ),
      ],
    ),
  );
}



void _startRecordingVoiceMessage() async {
    try {
      await _audioRecorder.openRecorder();
      await _audioRecorder.startRecorder(toFile: 'path_to_save_recording');
      // ignore: avoid_print
      print('Recording started.');
    } catch (e) {
      // ignore: avoid_print
      print('Error starting recording: $e');
    }
  }
  void _stopRecordingVoiceMessage() async {
    try {
      await _audioRecorder.stopRecorder();
      await _audioRecorder.closeRecorder();
      // ignore: avoid_print
      print('Recording stopped.');

      // Now you can handle the recorded audio file (e.g., send it in a chat message)
    } catch (e) {
      // ignore: avoid_print
      print('Error stopping recording: $e');
    }
  }


void _sendFileMessage(BuildContext context, PlatformFile file) async {
  String senderName = widget.senderName;
  String senderId = widget.cne;

  try {
    String fileType = _getFileType(file);
    String downloadUrl = await _uploadFileToStorage(file);

    FirebaseFirestore.instance
        .collection('EST-groupes')
        .doc(widget.chatGroupId.isNotEmpty ? widget.chatGroupId[0].id : null)
        .collection('messages')
        .add({
      'content': 'File: ${file.name}',
      'fileUrl': downloadUrl,
      'fileType': fileType, // Pass file type
      'sender': senderId,
      'senderName': senderName,
      'timestamp': DateTime.now(),
    });
  } catch (e) {
    if (kDebugMode) {
      print('Failed to upload file: $e');
    }
  }
}




String _getFileType(PlatformFile file) {
  String extension = file.extension?.toLowerCase() ?? '';
  switch (extension) {
    case 'pdf':
      return 'PDF';
    case 'doc':
    case 'docx':
      return 'Word';
    case 'xml':
      return 'XML';
    case 'jpg':
    case 'jpeg':
    case 'png':
      return 'Image';
    case 'mp4':
    case 'mov':
    case 'avi':
      return 'Video';
    default:
      return 'File';
  }
}




Future<String> _uploadFileToStorage(PlatformFile file) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child('chat_files/${file.name}');
  UploadTask uploadTask = ref.putFile(File(file.path!));

  TaskSnapshot taskSnapshot = await uploadTask;
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();

  return downloadUrl;
}





  // ignore: unused_element
  void _sendVoiceMessage() {
    // ignore: avoid_print
    print('Voice message sent');
  }

Future<void> _sendMessage(BuildContext context) async {
  String messageText = _messageController.text.trim();
  if (messageText.isNotEmpty) {
    String senderName = widget.senderName;
    String senderId = widget.cne; // Ensure to include sender ID

    try {
      await FirebaseFirestore.instance
          .collection('EST-groupes')
          .doc(widget.chatGroupId.isNotEmpty ? widget.chatGroupId[0].id : null)
          .collection('messages')
          .add({
        'content': messageText,
        'sender': senderId, // Use senderId for sender field
        'senderName': senderName,
        'timestamp': DateTime.now(),
        'fileUrl': null,
        'fileType': null,
      });
      _messageController.clear(); // Clear the message
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Failed to send message: $e');
      }
    }
  }
}




 Future<void> _deleteMessage(String messageId) async {
    try {
      await FirebaseFirestore.instance
          .collection('EST-groupes')
          .doc(widget.chatGroupId.isNotEmpty ? widget.chatGroupId[0].id : null)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Failed to delete message: $e');
      }
    }
  }
}
