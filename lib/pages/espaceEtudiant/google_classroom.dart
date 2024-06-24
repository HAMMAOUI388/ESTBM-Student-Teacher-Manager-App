import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/classroom/v1.dart' as classroom;
import 'package:googleapis_auth/auth_io.dart' as auth;

const String clientId = '1016561479530-00aath6ral217vcsqnjc2dff7qbmh3bu.apps.googleusercontent.com'; // Replace 'YOUR_CLIENT_ID' with your actual client ID

class GoogleClassroomTdsPage extends StatefulWidget {
  const GoogleClassroomTdsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GoogleClassroomTdsPageState createState() => _GoogleClassroomTdsPageState();
}

class _GoogleClassroomTdsPageState extends State<GoogleClassroomTdsPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    classroom.ClassroomApi.classroomCoursesReadonlyScope,
  ]);

  @override
  void initState() {
    super.initState();
    _handleSignIn();
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // Obtain credentials
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        // ignore: unused_local_variable
        final auth.AccessCredentials credentials = auth.AccessCredentials(
          auth.AccessToken(
            'Bearer',
            googleAuth.accessToken!,
            DateTime.now().add(const Duration(minutes: 60)).toUtc(), // Convert to UTC
          ),
          googleAuth.accessToken,
          ['https://www.googleapis.com/auth/classroom.courses.readonly'], // Added scopes parameter
        );

Future<void> prompt(String url) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Dialog cannot be dismissed by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Grant Access'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text('To grant access, please follow the link below:'),
              const SizedBox(height: 10),
              Text(url),
              const SizedBox(height: 20),
              const Text('Once you have granted access, you can close this dialog.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}


final auth.AutoRefreshingAuthClient client = await auth.clientViaUserConsent(
  auth.ClientId(clientId, ''),
  ['https://www.googleapis.com/auth/classroom.courses.readonly'], // Added scopes parameter
  prompt,
);

        // Fetch courses
        _fetchCourses(client); // Pass the client to the method
      } else {
        // Handle sign-in failure
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error signing in: $error');
      }
    }
  }

  Future<void> _fetchCourses(auth.AutoRefreshingAuthClient client) async {
    try {
      setState(() {
        // Use the client to fetch courses
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching courses: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geeclass',
      theme: ThemeData(
        fontFamily: "Inter",
      ),
    );
  }
}
