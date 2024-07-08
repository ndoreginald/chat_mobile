import 'package:flutter/material.dart';
import 'package:message_app/components/my_button.dart';
import 'package:message_app/components/my_text_fields.dart';
import 'package:message_app/services/auth/auth.services.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();

  Future<void> signUp() async {
    // Implémenter la logique de création de compte ici
    String email = emailController.text;
    String password = pwdController.text;
    String confirmPassword = confirmPwdController.text;

    if (password != confirmPassword) {
      // Afficher une alerte ou un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Les mots de passe ne correspondent pas"),),);
      return;

    } else {
      // Logique pour créer un compte
      print("Compte créé avec succès !");
    }
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.signUpWithEmailandPassword(email, password);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),
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
                const SizedBox(height: 30),
                Icon(
                  Icons.message,
                  size: 150,
                  color: Colors.grey[500],
                ),

                const Text(
                  "Create an account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 20),

                MyTextField(
                  controller: pwdController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                MyTextField(
                  controller: confirmPwdController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                MyButton(
                  onTap: signUp,
                  text: 'Sign Up',
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a member?"),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
