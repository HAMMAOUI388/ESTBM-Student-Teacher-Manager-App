import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  ChatUser muself = ChatUser(id: "1", firstName: "You");
  ChatUser bot = ChatUser(id: "2", firstName: "Chat GPT");
  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];
  late SharedPreferences _prefs;







  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    _prefs = await SharedPreferences.getInstance();
    final savedMessages = _prefs.getStringList('chat_history') ?? [];
    setState(() {
      allMessages = savedMessages
          .map((json) => ChatMessage.fromJson(jsonDecode(json)))
          .toList();
    });
  }

  Future<void> _saveChatHistory() async {
    final jsonMessages =
        allMessages.map((message) => jsonEncode(message.toJson())).toList();
    await _prefs.setStringList('chat_history', jsonMessages);
  }

  final ourUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyAq5nG4LA04mzSOZ68P5j12nydttC3Ed9U";
  final header = {'Content-Type': 'application/json'};



  getData(ChatMessage m) async {
    typing.add(bot);
    setState(() {});
    var data = {
      "contents": [
        {"parts": [{"text": m.text}]}
      ]
    };

    

  try {
    var value = await http.post(Uri.parse(ourUrl), headers: header, body: jsonEncode(data));
    if (value.statusCode == 200) {
      var result = jsonDecode(value.body);
      if (kDebugMode) {
        print(result["candidates"][0]["content"]["parts"][0]["text"]);
      }
      ChatMessage m1 = ChatMessage(
        user: bot,
        createdAt: DateTime.now(),
        text: result["candidates"][0]["content"]["parts"][0]["text"],
      );
      allMessages.insert(0, m1);
      _saveChatHistory(); // Save chat history after receiving a response from chatbot
    } else {
      if (kDebugMode) {
        print("Error occurred");
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error occurred: $e");
    }
  }

  typing.remove(bot);
  setState(() {}); // Move setState outside the try-catch block
}


  // Function to copy message text to clipboard
  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chat Bot for you"),
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: [
          Image.asset(
            'lib/images/pattdark.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          DashChat(
            messageOptions: MessageOptions(
              showTime: true,
              textColor: Colors.black,
              containerColor: Colors.blueGrey,
              currentUserContainerColor: const Color.fromARGB(255, 33, 43, 48),
              showOtherUsersAvatar: false,
              onLongPressMessage: (message) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Message Options'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              allMessages.remove(message);
                              _saveChatHistory();
                              setState(() {});
                            },
                            child: const Text('Delete Message'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              copyToClipboard(message.text);
                            },
                            child: const Text('Copy Message'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            typingUsers: typing,
            currentUser: ChatUser(id: "1", firstName: "You"),
onSend: (ChatMessage m) {
  if (kDebugMode) {
    print('onSend callback triggered for message: ${m.text}');
  }
  
  // Check if the message already exists in the list
  if (!allMessages.contains(m)) {
    if (kDebugMode) {
      print('Inserting message into the list: ${m.text}');
    }
    
    // Add the message to the list
    allMessages.insert(0, m);

    // Send the message
    getData(m);

    // Save chat history after sending a message
    _saveChatHistory();

    // Update the UI
    setState(() {});
  } else {
    if (kDebugMode) {
      print('Message already exists in the list: ${m.text}');
    }
  }
},



            messages: allMessages,
          ),
        ],
      ),
    );
  }
}
