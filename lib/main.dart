import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String apiKey1 = 'lg1BcmATHHOoTUrqmpMqwKgXa';
  final String apiSecretKey1 = 'HUWwjez5tNGY7WJ0ELbutCCVwcZL10Ko7yAY5s6wvQABZ9Ccsp';
///

  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = new TwitterLogin(
        apiKey: apiKey1,
        apiSecretKey:apiSecretKey1,
        redirectURI: 'twitterloginexample://twitter/callback'
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  }
  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('twitter_login example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              const Text(
                'Twitter Login!!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Image.network(
                'https://freepnglogo.com/images/all_img/1691832581twitter-x-icon-png.png',
                width: 200,
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  child: const Text('Login With Twitter'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                    minimumSize: MaterialStateProperty.all<Size>(const Size(160, 48)),
                  ),
                  onPressed: () async {
                    await signInWithTwitter();
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}