import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorhub/chatapp/screen/chat_screen.dart';
import 'package:tutorhub/chatapp/screen/signup.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      // Sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
      }).onError((error, stackTrace){
        print(error.toString());
      });
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      // Handle sign-in errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: height / 4.0,
                width: width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF7f30fe), Color(0xFF6380fb)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(width, 105))),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 60.0, left: width * 0.4, right: width * 0.4),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ),
                  Text("Log in to your account",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color(0xFFbbb0ff))),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 45.0, horizontal: 20),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        height: height / 2,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email_outlined),
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.password),
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: (){
                                signIn();
                                
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: width * 0.15),
                                child: Material(
                                  elevation: 5,
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    height: 45,
                                    width: width / 2,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF7f30fe),
                                              Color(0xFF6380fb)
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account? ",style: TextStyle(fontSize: 16,color: Colors.black),),
                                InkWell(
                                   onTap:() => {Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),}, 
                                  child: Text("Sign Up",style: TextStyle(fontSize: 16,color: Color(0xFF7f30fe)),))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
