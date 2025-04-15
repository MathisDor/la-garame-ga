// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIA = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo amélioré
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green[900],
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                  width: 120,
                ),
              ),
              const SizedBox(height: 30),
              
              // Sélecteur d'IA amélioré
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Nombre d'adversaires IA",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Sélecteur visuel
                    Wrap(
                      spacing: 10,
                      children: List.generate(3, (index) {
                        final iaCount = index + 1;
                        return ChoiceChip(
                          label: Text('$iaCount IA'),
                          selected: _selectedIA == iaCount,
                          onSelected: (selected) {
                            setState(() {
                              _selectedIA = iaCount;
                            });
                          },
                          selectedColor: Colors.green,
                          labelStyle: TextStyle(
                            color: _selectedIA == iaCount 
                                ? Colors.white 
                                : Colors.black,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              
              // Bouton Jouer amélioré
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context, 
                    '/game', 
                    arguments: _selectedIA,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  "COMMENCER LA PARTIE",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Bouton Règles stylisé
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/rules');
                },
                icon: Icon(Icons.help_outline, color: Colors.grey[400]),
                label: Text(
                  "Voir les règles du jeu",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}