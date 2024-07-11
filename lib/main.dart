import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tutorhub/tutorhub/screen/user/payment_screen.dart';
import 'package:tutorhub/tutorhub/screen/user/user_home_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // home:StreamBuilder<User?>(
      // stream: FirebaseAuth.instance.authStateChanges(),
      // builder: (context, snapshot) {
      //   if (snapshot.connectionState == ConnectionState.waiting) {
      //     // Loading indicator while checking authentication state
      //     return CircularProgressIndicator();
      //   } else if (snapshot.hasData && snapshot.data != null) {
          
      //     return ChatScreen(); 
      //   } else {
      //     return SignInPage(); 
      //   }
      // },
      // )
      home: MyAppp(),
    );
  }
}
