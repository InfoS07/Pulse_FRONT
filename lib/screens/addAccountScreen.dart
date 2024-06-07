import 'package:flutter/material.dart';
import 'package:pulse_front/main.dart';
import 'package:pulse_front/screens/connexionPage.dart';
import 'package:pulse_front/screens/onboardingPage.dart';



class AddAccountScreen extends StatelessWidget {
  const AddAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 37, 36, 36),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Tu as déjà un compte ?',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Reprends là où tu en étais.',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 3, 126, 124),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConnexionScreen()),
                  );
                },
                child: const Text(
                  'SE CONNECTER',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Tu viens d\'arriver ?',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Commence dès maintenant.',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Color.fromARGB(255, 3, 126, 124)),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                  );
                },
                child: const Text(
                  'C\'EST PARTI !',
                  style: TextStyle(color: Color.fromARGB(255, 3, 126, 124)),
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
