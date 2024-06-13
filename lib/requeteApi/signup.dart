import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pulse_front/screens/loginScreen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pulse_front/screens/manageAccountPage.dart'; // Importez la page ManageAccountPage

Future<void> signUp(BuildContext context, String email, String password, String lastName, String firstName, String username, String heightCm, String weightKg, String targetWeight) async {
  final url = Uri.parse('https://xbxtezmargogbsninnby.supabase.co/auth/v1/signup');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhieHRlem1hcmdvZ2JzbmlubmJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM3MTEwMjgsImV4cCI6MjAyOTI4NzAyOH0.8P1GKYPpRT-gDtpX_rseS9c80TiZJ1c4M8vLTQbgp0A'
    },
    body: jsonEncode({
      'email': email,
      'password': password,
      'data': {
        'last_name': lastName,
        'first_name': firstName,
        'username': username,
        'birth_date': '2000-01-01', // Assurez-vous d'ajouter la date de naissance correctement
        'height_cm': heightCm,
        'weight_kg': weightKg,
        'target_weight': targetWeight,
      },
    }),
  );

  if (response.statusCode == 200) {
    // Connexion après inscription réussie
    final loginResponse = await http.post(
      Uri.parse('https://xbxtezmargogbsninnby.supabase.co/auth/v1/token?grant_type=password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhieHRlem1hcmdvZ2JzbmlubmJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM3MTEwMjgsImV4cCI6MjAyOTI4NzAyOH0.8P1GKYPpRT-gDtpX_rseS9c80TiZJ1c4M8vLTQbgp0A'
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (loginResponse.statusCode == 200) {
      final responseData = jsonDecode(loginResponse.body);
      final token = responseData['access_token'];

      // Sauvegarder le compte dans SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      List<String>? accounts = prefs.getStringList('accounts');
      accounts = accounts ?? [];

      Map<String, String> accountMap = {
        'email': email,
        'token': token,
      };

      // Ajouter le compte à la liste si non existant
      if (!accounts.contains(jsonEncode(accountMap))) {
        accounts.add(jsonEncode(accountMap));
      }

      await prefs.setStringList('accounts', accounts);

      // Naviguer vers la ManageAccountPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          /*builder: (context) => ManageAccountsScreen(
            onUpdateAccounts: (updatedAccounts) {
              // Mettez à jour les comptes si nécessaire
              prefs.setStringList(
                'accounts',
                updatedAccounts.map((account) => jsonEncode(account)).toList(),
              );
            },
          ),*/
          builder: (context) => LoginScreen()
        ),
      );
    } else {
      print('Erreur lors de la connexion après l\'inscription: ${loginResponse.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la connexion après l\'inscription. Veuillez réessayer plus tard.')),
      );
    }
  } else {
    print('Erreur lors de l\'inscription: ${response.statusCode}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur lors de l\'inscription. Veuillez réessayer plus tard.')),
    );
  }
}
