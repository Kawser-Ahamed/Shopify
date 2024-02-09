import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleTest extends StatefulWidget {
  const GoogleTest({super.key});

  @override
  State<GoogleTest> createState() => _GoogleTestState();
}

class _GoogleTestState extends State<GoogleTest> {

//  Future<void> googleSignIn() async{
//   FirebaseAuth auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//    GoogleSignInAccount? account = await googleSignIn.signIn();

//     GoogleSignInAuthentication authentication = await account!.authentication;

//     AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: authentication.accessToken,
//       idToken: authentication.idToken,
//     );
//     UserCredential userCredential = await auth.signInWithCredential(credential);

//     debugPrint(userCredential.user!.email);
//  }

 Future<bool> isFirstTimeSignIn() async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Trigger Google sign-in flow
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      // Obtain GoogleSignInAuthentication for exchanging Google tokens for Firebase credentials
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      // Create Firebase credentials with Google tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in to Firebase with Google credentials
      final UserCredential userCredential = await auth.signInWithCredential(credential);

      if(userCredential.additionalUserInfo?.isNewUser ?? false){
        debugPrint('New User');
        debugPrint(userCredential.user!.email);
      }
      else{
        debugPrint('Old User');
      }
      // Check if the user is newly signed in
      return userCredential.additionalUserInfo?.isNewUser ?? false;
    } else {
      // Google sign-in was cancelled or failed
      return false;
    }
  } catch (error) {
    // Handle errors
    debugPrint('Error checking first time sign-in: $error');
    return false;
  }
}


 Future<void> logout() async{
  GoogleSignIn googleSignIn = GoogleSignIn();
  googleSignIn.signOut();
  //FirebaseAuth.instance.signOut();
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap:(){
                isFirstTimeSignIn();
              },
              child: Container(
                height:50,
                width: 300,
                color: Colors.white,
                child: const Center(
                  child: Text("Sign In"),
                ),
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap:(){
                logout();
              },
              child: Container(
                height:50,
                width: 300,
                color: Colors.white,
                child: const Center(
                  child: Text("Logout"),
                ),
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap:(){

              },
              child: Container(
                height:50,
                width: 300,
                color: Colors.white,
                child: const Center(
                  child: Text("Send Data"),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}