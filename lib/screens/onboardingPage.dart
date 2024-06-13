import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pulse_front/requeteApi/signup.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String email = '';
  String password = '';
  String lastName = '';
  String firstName = '';
  String username = '';
  String heightCm = '150';
  String weightKg = '50';
  String targetWeight = '50';
  DateTime? birthDate;

  Map<String, List<String>> reponseUser = {
    'type_sport': [],
    'niveau_experience': [],
    'objectif': [],
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (_currentPage > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text('Création de compte'),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            _buildQuestionPage(
              context,
              'Quel type de sport vous intéresse ?',
              ['Course à pied', 'Cyclisme', 'Natation', 'Musculation'],
              'type_sport',
            ),
            _buildQuestionPage(
              context,
              'Quel est votre niveau d\'expérience ?',
              ['Débutant', 'Intermédiaire', 'Avancé'],
              'niveau_experience',
            ),
            _buildQuestionPage(
              context,
              'Quel est votre objectif ?',
              ['Perte de poids', 'Gain de muscle', 'Endurance', 'Bien-être général'],
              'objectif',
            ),
            _buildSignUpForm(context),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(80.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _currentPage < 3 || _formKey.currentState?.validate() == false
                ? Colors.grey
                : const Color.fromARGB(255, 3, 126, 124),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          onPressed: () async {
            if (_currentPage < 3) {
              // Vérifier si au moins une réponse est sélectionnée pour la page actuelle
              var currentQuestion = _currentPage == 0 ? 'type_sport' : _currentPage == 1 ? 'niveau_experience' : 'objectif';
              if (reponseUser[currentQuestion]!.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Veuillez sélectionner au moins une réponse pour cette question.')),
                );
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            } else {
              // Dernier écran : vérifier également le formulaire
              if (_formKey.currentState?.validate() ?? false) {
                await signUp(
                  context,
                  email,
                  password,
                  lastName,
                  firstName,
                  username,
                  heightCm,
                  weightKg,
                  targetWeight,
                );
              }
            }
          },

          child: const Text(
            'CONTINUER',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionPage(BuildContext context, String question, List<String> options, String key) {
    // Ajouter l'option "Autre" si elle n'est pas déjà présente
    if (!options.contains('Autre')) {
      options.add('Autre');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            question,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          for (var option in options)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: OptionButton(
                label: option,
                isSelected: reponseUser[key]!.contains(option),
                onPressed: () {
                  setState(() {
                    if (reponseUser[key]!.contains(option)) {
                      reponseUser[key]!.remove(option);
                    } else {
                      reponseUser[key]!.add(option);
                    }
                  });
                },
              ),
            ),
          const Spacer(),
        ],
      ),
    );
  }

Widget _buildSignUpForm(BuildContext context) {
  return Form(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          _buildTextField(
            'Email',
            (value) {
              email = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Entrez un email valide';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            'Mot de passe (au moins 6 caractères, une majuscule, un chiffre et un caractère spécial)',
            (value) {
              password = value;
            },
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return 'Le mot de passe doit contenir au moins 6 caractères';
              }
              if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$&*]).{6,}$').hasMatch(value)) {
                return 'Le mot de passe doit contenir au moins une majuscule, un chiffre et un caractère spécial';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildTextField('Nom', (value) {
            lastName = value;
          }),
          const SizedBox(height: 20),
          _buildTextField('Prénom', (value) {
            firstName = value;
          }),
          const SizedBox(height: 20),
          _buildTextField('Nom d\'utilisateur', (value) {
            username = value;
          }),
          const SizedBox(height: 20),
          _buildDropdownField('Poids en kg', (value) {
            weightKg = value;
          }, ['50', '60', '70', '80', '90', '100']),
          const SizedBox(height: 20),
          _buildDropdownField('Taille en cm', (value) {
            heightCm = value;
          }, ['150', '160', '170', '180', '190', '200']),
          const SizedBox(height: 20),
          _buildDropdownField('Poids visé en kg', (value) {
            targetWeight = value;
          }, ['50', '60', '70', '80', '90', '100']),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}


  Widget _buildTextField(String hint, Function(String) onChanged, {bool isPassword = false, String? Function(String?)? validator}) {
    return Column(
      children: [
        const SizedBox(height: 20),
        TextFormField(
          onChanged: (value) {
            setState(() {
              onChanged(value);
            });
          },
          obscureText: isPassword,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String hint, Function(String) onChanged, List<String> options) {
    return Column(
      children: [
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          onChanged: (value) {
            setState(() {
              onChanged(value!);
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Sélectionnez une option';
            }
            return null;
          },
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class OptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const OptionButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color.fromARGB(255, 3, 126, 124) : Colors.transparent,
        side: const BorderSide(color: Color.fromARGB(255, 3, 126, 124)),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.black : const Color.fromARGB(255, 3, 126, 124),
        ),
      ),
    );
  }
}
