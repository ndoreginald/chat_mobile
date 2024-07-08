import 'package:flutter/material.dart';
import 'package:message_app/pages/login.pages.dart';
import 'package:message_app/pages/register.pages.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister ({super.key});

  @override
  State<StatefulWidget> createState() => _LoginOrRegister();

}

class _LoginOrRegister extends State<LoginOrRegister>
{
  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
    return LoginPage(onTap: togglePages);
  }
    else{
      return RegisterPage(onTap: togglePages);
    }
    }
}