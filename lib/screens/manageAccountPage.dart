import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ManageAccountsScreen extends StatefulWidget {
  final Function(List<Map<String, String>>) onUpdateAccounts;

  const ManageAccountsScreen({super.key, required this.onUpdateAccounts});

  @override
  _ManageAccountsScreenState createState() => _ManageAccountsScreenState();
}

class _ManageAccountsScreenState extends State<ManageAccountsScreen> {
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

  Future<void> _deleteAccount(String email) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? accountStrings = prefs.getStringList('accounts');

    if (accountStrings != null) {
      accountStrings.removeWhere((account) {
        final accountMap = Map<String, String>.from(jsonDecode(account));
        return accountMap['email'] == email;
      });

      await prefs.setStringList('accounts', accountStrings);

      setState(() {
        accounts = accountStrings.map((account) => Map<String, String>.from(jsonDecode(account))).toList();
      });

      widget.onUpdateAccounts(accounts);
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
            Navigator.pop(context, accounts);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'You can remove accounts that you don’t want to be saved on this device',
                style: TextStyle(color: Colors.white54, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final account = accounts[index];
                    return AccountTile(
                      name: account['email']!,
                      email: account['email']!,
                      onDelete: () => _deleteAccount(account['email']!),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, accounts);
                },
                child: const Text(
                  'DONE EDITING',
                  style: TextStyle(color: Colors.white54, fontSize: 16),
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
      ),
    );
  }
}
