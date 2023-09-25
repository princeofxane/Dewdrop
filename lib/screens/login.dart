import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'device_and_segment_setup.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);
        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      // Create an instance of the firebase auth and google sing in.
      // FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Trigger authentication flow.
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request.
      final GoogleSignInAuthentication googleAuth = await googleUser!
          .authentication;

      // Create new credentials.
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      // Sign in the user with the credentials.
      final UserCredential userCredential = await auth.signInWithCredential(
          credential);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login Page'),
      // ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 150.0,
              width: 100.0,
              padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Image.asset('resources/water_drop.jpg'),
              ),
            ),
            const Text('LightUp',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Your home control',
              style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.lightBlueAccent,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter email address'
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'
                ),
              ),
            ),
            /* ---------- Login button ---------- */
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Container(
                height: 50,
                width: 200,
                padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black)
                ),
                child: const Center(
                  child: Text( 'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                ),
              ),
            ),
            const SizedBox(height: 16,),
            /* ---------- Google sign in button ---------- */
            ElevatedButton(
              onPressed: () async {
                signInWithGoogle();
                if(mounted) {
                  // Navigate user to device page.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DeviceSetupScreen()
                      )
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Container(
                height: 50,
                width: 200,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black)
                ),
                child: Row(
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      // padding: EdgeInsets.only(top: 40),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('resources/google_logo.jpg'),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    const Text('Sign in with Google',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DeviceSetupScreen()
                      )
                  );
                },
                child: Text('Go Home')
            )
          ],
        ),
      ),
    );
  }
}
