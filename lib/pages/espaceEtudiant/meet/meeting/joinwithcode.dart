import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/models/data_store.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/screens/meeting_screen.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/services/join_service.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/services/sdk_initializer.dart';
import 'package:provider/provider.dart';


class JoinWithCode extends StatefulWidget {
  const JoinWithCode({super.key});

  @override
  State<JoinWithCode> createState() => _JoinWithCodeState();
}

class _JoinWithCodeState extends State<JoinWithCode> {
  late UserDataStore _dataStore;
  bool isLoading = false;

  @override
  void initState() {
    getPermissions();
    super.initState();
  }

  void getPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();

    while ((await Permission.camera.isDenied)) {
      await Permission.camera.request();
    }
    while ((await Permission.microphone.isDenied)) {
      await Permission.microphone.request();
    }
  }

  //Handles room joining functionality
   Future<bool> joinRoom() async {
     setState(() {
       isLoading = true;
     });
     //The join method initialize sdk,gets auth token,creates HMSConfig and helps in joining the room
     await SdkInitializer.hmssdk.build();
     _dataStore = UserDataStore();
 
     //Here we are attaching a listener to our DataStoreClass
     _dataStore.startListen();
     bool isJoinSuccessful = await JoinService.join(SdkInitializer.hmssdk);
     if (!isJoinSuccessful) {
       return false;
     }
     setState(() {
       isLoading = false;
     });
     return true;
   }


  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join meeting with code"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'lib/images/patt.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                const SizedBox(height: 50),
                Image.network(
                  "https://user-images.githubusercontent.com/67534990/127776450-6c7a9470-d4e2-4780-ab10-143f5f86a26e.png",
                  fit: BoxFit.cover,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Enter meeting code below",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: Card(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Example : abcefgdh"),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool isJoined = await joinRoom();
                    if (isJoined) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              ListenableProvider.value(
                                  value: _dataStore,
                                  child: const MeetingScreen())));
                    } else {
                      const SnackBar(content: Text("Error"));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(350, 30),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Join",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}