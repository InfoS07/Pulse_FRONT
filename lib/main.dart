import 'package:flutter/material.dart';
import 'package:pulse_front/screens/goalsPage.dart';
import 'package:pulse_front/screens/homePage.dart';
import 'package:pulse_front/screens/loginScreen.dart';
import 'package:pulse_front/screens/manageAccountPage.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/addAccountScreen.dart';

Future<void> main() async {

  await Supabase.initialize(
    url: 'https://xbxtezmargogbsninnby.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhieHRlem1hcmdvZ2JzbmlubmJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM3MTEwMjgsImV4cCI6MjAyOTI4NzAyOH0.8P1GKYPpRT-gDtpX_rseS9c80TiZJ1c4M8vLTQbgp0A',
  );

  runApp(const MyApp());
}

  final supabase = Supabase.instance.client;
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}



