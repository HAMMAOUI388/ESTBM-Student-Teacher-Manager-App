//Package imports
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/models/data_store.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/screens/meeting_screen.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/services/join_service.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/services/sdk_initializer.dart';
// ignore: depend_on_referenced_packages
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';


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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: const Text("Meet"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
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
                  child: const Text('New meeting'),
                ),
                OutlinedButton(
                    style: Theme.of(context)
                        .outlinedButtonTheme
                        .style!
                        .copyWith(
                            side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.white)),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent),
                            foregroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white)),
                    onPressed: () {},
                    child: const Text('Join with a code'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
