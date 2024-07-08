import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message_app/components/my_button.dart';
import 'package:message_app/components/my_text_fields.dart';
import 'package:message_app/services/auth/auth.services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage>{

  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  void signIn () async{
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.signInWithEmailandPassword(emailController.text, pwdController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),),
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
              const SizedBox(height: 50,),
              Icon(Icons.message,
              size: 150,
              color: Colors.grey[500],
          ),

              const Text("Welcome back you've been missed",
              style: TextStyle(
                fontSize: 16,
              ),
          ),

              const SizedBox(height: 50,),

              MyTextField(controller: emailController,
                  hintText: 'Email',
                  obscureText: false),

              const SizedBox(height: 20,),

              MyTextField(controller: pwdController, hintText: "password", obscureText: true,),

              const SizedBox(height: 30,),

              MyButton(onTap: signIn, text: "Sign In"),

              const SizedBox(height: 30,),

             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Text("Not a member?"),
              const SizedBox(width:4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text("Register now", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                ),
              ),
            ],
          )
        ],
      ),
           ),
        ),
      ),
         );
    }
  }

