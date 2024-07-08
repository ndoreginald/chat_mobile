import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:message_app/firebase_options.dart';
import 'package:message_app/pages/home.page.dart';
import 'package:message_app/pages/login.pages.dart';
import 'package:message_app/pages/register.pages.dart';
import 'package:message_app/services/auth/auth.gate.dart';
import 'package:message_app/services/auth/auth.services.dart';
import 'package:message_app/services/auth/login_or_register.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      ChangeNotifierProvider(create: (context) => AuthService(),
          child: const MyApp(),)
     );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: AuthGate(),
    );
  }
}
