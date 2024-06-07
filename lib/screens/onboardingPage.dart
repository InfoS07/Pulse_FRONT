import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<List<String>> _selectedAnswers = [[], [], [], []];

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
        title: Container(
          height: 20,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / 4, // Assuming 4 onboarding steps
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 3, 126, 124)),
            ),
          ),
        ),
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
            _buildPage(
              context,
              SizedBox(
                width: 200, // Change this value to your desired width
                height: 200, // Change this value to your desired height
                child: Image.asset('assets/duo.png'),
              ),
              'Salut ! Prêt à commencer ?',
            ),
            _buildQuestionPage(
              context,
              'Quel type de sport vous intéresse ?',
              ['Course à pied', 'Cyclisme', 'Natation', 'Musculation'],
              1,
            ),
            _buildQuestionPage(
              context,
              'Quel est votre niveau d\'expérience ?',
              ['Débutant', 'Intermédiaire', 'Avancé'],
              2,
            ),
            _buildQuestionPage(
              context,
              'Quel est votre objectif ?',
              ['Perte de poids', 'Gain de muscle', 'Endurance', 'Bien-être général'],
              3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(80.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _currentPage == 0 || _selectedAnswers[_currentPage].isNotEmpty
                ? const Color.fromARGB(255, 3, 126, 124)
                : Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          onPressed: _currentPage == 0 || _selectedAnswers[_currentPage].isNotEmpty
              ? () {
                  if (_currentPage < 3) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  }
                }
              : null,
          child: const Text(
            'CONTINUER',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, Widget image, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          image,
          const SizedBox(height: 20),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildQuestionPage(BuildContext context, String question, List<String> options, int pageIndex) {
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
                isSelected: _selectedAnswers[pageIndex].contains(option),
                onPressed: () {
                  setState(() {
                    if (_selectedAnswers[pageIndex].contains(option)) {
                      _selectedAnswers[pageIndex].remove(option);
                    } else {
                      _selectedAnswers[pageIndex].add(option);
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

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Inscrivez-vous pour continuer',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Confirmer le mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 126, 124),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  // Sign up logic here
                },
                child: const Text(
                  'S\'INSCRIRE',
                  style: TextStyle(color: Colors.black),
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
