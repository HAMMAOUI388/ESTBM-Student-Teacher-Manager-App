import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/models/data_store.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/screens/meeting_screen.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/services/join_service.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/services/sdk_initializer.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
// ignore: depend_on_referenced_packages




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  final String _meetingCode = "abcdfgqw";
// 
//   @override
//   void initState() {
//     var uuid = const Uuid();
//     _meetingCode = uuid.v1().substring(0, 8);
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New meeting"),
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
                  "https://user-images.githubusercontent.com/67534990/127776392-8ef4de2d-2fd8-4b5a-b98b-ea343b19c03e.png",
                  fit: BoxFit.cover,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Enter meeting code below",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Card(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(
   leading: const Icon(Icons.link),
  title: SelectableText(
    _meetingCode,
    style: const TextStyle(fontWeight: FontWeight.w300),
  ),
  trailing: IconButton(
    icon: const Icon(Icons.copy),
    onPressed: () {
      Clipboard.setData(ClipboardData(text: _meetingCode));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meeting code copied to clipboard')),
      );
    },
  ),
),

                  ),
                ),
                const Divider(thickness: 1, height: 40, indent: 20, endIndent: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Share.share("Meeting Code : $_meetingCode");
                  },
                  icon: const Icon(Icons.arrow_drop_down),
                  label: const Text("Share invite"),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.white),
                    fixedSize: const Size(350, 30),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(   onPressed: () async {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: <Widget>[
                              ListTile(
                                title: const Row(
                                  children: [
                                    Icon(Icons.video_call),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Start an instant meeting'),
                                  ],
                                ),
                                onTap: () async {
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
                              ),
                              ListTile(
                                title: const Row(
                                  children: [
                                    Icon(Icons.close),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Close'),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },

                  icon: const Icon(Icons.video_call),
                  label: const Text("start call"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.indigo,
                    side: const BorderSide(color: Colors.indigo),
                    fixedSize: const Size(350, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
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

