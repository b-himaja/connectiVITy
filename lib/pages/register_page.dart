import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/my_button.dart';
import 'package:untitled/components/my_textfield.dart';

import '../helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  void register() async {
    //show loading circle
    showDialog(context: context,
        builder: (context) =>
        const Center(
          child: CircularProgressIndicator(),
        )
    );

    //passwords match

    if (passwordController.text != confirmController.text) {
      Navigator.pop(context);

      displayMessageToUser("Your passwords don't match", context);
    }

    else {
      //create the user

      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );

        createUserDocument(userCredential);

        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        displayMessageToUser(e.code, context);
      }
    }
  }

  //add user data to firestore

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential!= null && userCredential.user != null){
      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set({
        'email' : userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //logo
                    Image.asset(
                      'assets/vitlogo.png',
                      width: 200,
                      height: 80,
                    ),

                    const SizedBox(height:25),

                    //app name

                    Text(
                      "connectiVITy", style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height:25),

                    //username text field
                    MyTextField(
                      hintText: "Username",
                      obscureText: false,
                      controller: usernameController,
                    ),

                    const SizedBox(height:10),

                    //email text field
                    MyTextField(
                      hintText: "Email",
                      obscureText: false,
                      controller: emailController,
                    ),

                    const SizedBox(height:10),

                    //password text field
                    MyTextField(
                      hintText: "Password",
                      obscureText: true,
                      controller: passwordController,
                    ),

                    const SizedBox(height:10),

                    //confirm password text field
                    MyTextField(
                      hintText: "Confirm Password",
                      obscureText: true,
                      controller: confirmController,
                    ),



                    const SizedBox(height:25),

                    //register button
                    MyButton(
                      text: "Register",
                      onTap: register,
                    ),

                    const SizedBox(height:25),


                    //register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text("Already have an account? "),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "Login here",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],

                )
            )
        )
    );
  }
}
