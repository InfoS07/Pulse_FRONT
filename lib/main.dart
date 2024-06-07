import 'package:flutter/material.dart';
import 'package:pulse_front/screens/goalsPage.dart';
import 'package:pulse_front/screens/homePage.dart';
import 'package:pulse_front/screens/manageAccountPage.dart';
import 'screens/addAccountScreen.dart';

void main() {
  runApp(const MyApp());
}

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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              const Icon(Icons.emoji_emotions, size: 100, color: Color.fromARGB(255, 3, 126, 124)),
              const SizedBox(height: 20),
              const Text(
                'Sign back in',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Choose from accounts saved on this device',
                style: TextStyle(color: Colors.white54, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const AccountTile(name: 'Rafiq', email: 'messairafiq@gmail.com'),
              const SizedBox(height: 10),
              const AddAccountButton(),
              const Spacer(flex: 3),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ManageAccountsScreen()),
                  );
                },
                child: const Text(
                  'MANAGE ACCOUNTS',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountTile extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback? onDelete;

  const AccountTile({super.key, required this.name, required this.email, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(
            name[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          email,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: onDelete,
              )
            : null,
        onTap: () {
          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  HomePage()),
                  );
        },
      ),
    );
  }
}

class AddAccountButton extends StatelessWidget {
  const AddAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      child: ListTile(
        leading: const Icon(Icons.add, color: Colors.white),
        title: const Text(
          'Add another account',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddAccountScreen()),
          );
        },
      ),
    );
  }
}


