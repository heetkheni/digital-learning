import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorhub/chatapp/screen/chat_screen.dart';
import 'package:tutorhub/chatapp/screen/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController  = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  Future<void> signUp() async {
    try {
      // Create a new user account
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Add user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': emailController.text,
        'username': nameController.text,
        // Add additional user data as needed
      });
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
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
                        top: 60.0, left: width * 0.35, right: width * 0.35),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ),  
                  Text("Create your account",
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
                        height: height / 1.68,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
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
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (val){
                                    if(val == null || val.isEmpty){
                                      return "Enter your name";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              SizedBox(height: 20,),
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
                                child: TextFormField(
                                  controller: emailController,
                                  validator: (val){
                                    if(val == null || val.isEmpty){
                                      return "Enter your email";
                                    }
                                  },
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
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (val){
                                    if(val == null || val.isEmpty){
                                      return "Enter your password";
                                    }
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.password),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () { 
                                  signUp();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 30, horizontal: width * 0.15),
                                  child: Material(
                                    elevation: 5,
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          "Sign Up",
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
                                  Text("Already have an account? ",style: TextStyle(fontSize: 16,color: Colors.black),),
                                  InkWell(
                                    onTap:() => {Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage())),}, 
                                    child: Text("Sign In",style: TextStyle(fontSize: 16,color: Color(0xFF7f30fe)),))
                                ],
                              )
                            ],
                          ),
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