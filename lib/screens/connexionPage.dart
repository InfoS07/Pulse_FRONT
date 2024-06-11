import 'package:flutter/material.dart';
import 'package:pulse_front/main.dart';
import 'package:pulse_front/screens/loginScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});

  @override
  _ConnexionScreenState createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() {
      _loading = true;
    });

    final email = emailController.text;
    final password = passwordController.text;

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final session = response.session;
      final user = response.user;

      if (session != null && user != null) {
        // Save token and email in local storage
        final prefs = await SharedPreferences.getInstance();
        List<String>? accounts = prefs.getStringList('accounts');
        accounts = accounts ?? [];
        
        // Create account map
        Map<String, String> accountMap = {
          'email': email,
          'token': session.accessToken,
        };

        // Add account to accounts list if it doesn't exist
        if (!accounts.contains(jsonEncode(accountMap))) {
          accounts.add(jsonEncode(accountMap));
        }

        await prefs.setStringList('accounts', accounts);

        // Navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Login")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unexpected error occurred')),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Connectez-vous à votre compte',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Adresse Email',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Mot de Passe',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 126, 124),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: _loading ? null : _login,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'SE CONNECTER',
                        style: TextStyle(color: Colors.black),
                      ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  var url = Uri.parse('https://www.google.com/'); // Replace with your URL
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text(
                  'Mot de passe oublié ?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 3, 126, 124),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
