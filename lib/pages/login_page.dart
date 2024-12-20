import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/my_button.dart';
import 'package:untitled/components/my_textfield.dart';
import 'package:untitled/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {

  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void login() async{
    showDialog(context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
    );

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );

      if(context.mounted) Navigator.pop(context);
    }

    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
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
                "c o n n e c t i V I T y", style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height:25),

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

              //forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot Password?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary
                  )
                  ),

                ],
              ),

              const SizedBox(height:25),

              //sign in button
              MyButton(
                  text: "Login",
                  onTap: login,
              ),

              const SizedBox(height:25),


              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Register here",
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
