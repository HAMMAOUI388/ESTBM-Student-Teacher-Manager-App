import 'dart:convert';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class VideoCall extends StatefulWidget {
  String channelName = "test";

  VideoCall({super.key, required this.channelName});
  @override
  // ignore: library_private_types_in_public_api
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  late final AgoraClient _client;
  bool _loading = true;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    String link =
        "https://e612eb9d-6c4f-4272-9305-9e378e5f332d-00-22siean3wy4zr.spock.replit.dev/rtc/test/publisher/uid/1";

    Response response = await get(Uri.parse(link));
    Map data = jsonDecode(response.body);

    _client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
          appId: "401eb6e2224b4daeb0d55d35d9389882",
          tempToken:data["007eJxTYIgJjFtjfXuzXsLMpa55ok8fbrherptRZRfRZzRBV1Ey75oCg4mBYWqSWaqRkZFJkklKYmqSQYqpaYqxaYqlsYWlhYVRyiHjtIZARoaGVaVMjAwQCOKzMJSkFpcwMAAA7uIeFQ=="],
          channelName: widget.channelName,
        ),
        enabledPermission: [Permission.camera, Permission.microphone]);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => setState(() => _loading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  AgoraVideoViewer(
                    client: _client,
                  ),
                  AgoraVideoButtons(client: _client)
                ],
              ),
      ),
    );
  
  }
}