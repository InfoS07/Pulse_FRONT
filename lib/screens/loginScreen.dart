import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:pulse_front/screens/manageAccountPage.dart';
import 'package:pulse_front/screens/homePage.dart';
import 'package:pulse_front/screens/addAccountScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Map<String, String>> accounts = [];

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? accountStrings = prefs.getStringList('accounts');

    if (accountStrings != null) {
      setState(() {
        accounts = accountStrings.map((account) => Map<String, String>.from(jsonDecode(account))).toList();
      });
    }
  }

  Future<void> _navigateToManageAccounts() async {
    final updatedAccounts = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageAccountsScreen(
          onUpdateAccounts: (updatedAccounts) {
            setState(() {
              accounts = updatedAccounts;
            });
          },
        ),
      ),
    );

    if (updatedAccounts != null) {
      setState(() {
        accounts = updatedAccounts;
      });
    }
  }

  Future<void> _selectAccount(String email) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Assuming each account contains email and token
    final selectedAccount = accounts.firstWhere((account) => account['email'] == email);
    
    // Save the selected account's token to SharedPreferences
    await prefs.setString('token', selectedAccount['token']!);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

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
              const Spacer(flex: 1),
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
              // Display the accounts
              Expanded(
                flex: 6,
                child: ListView.builder(
                  itemCount: accounts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == accounts.length) {
                      return const AddAccountButton();
                    }
                    final account = accounts[index];
                    return AccountTile(
                      name: account['email']!,
                      email: account['email']!,
                      onTap: () => _selectAccount(account['email']!),
                    );
                  },
                ),
              ),
              const Spacer(flex: 1),
              TextButton(
                onPressed: _navigateToManageAccounts,
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
  final VoidCallback? onTap;

  const AccountTile({super.key, required this.name, required this.email, this.onTap});

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
        onTap: onTap,
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
