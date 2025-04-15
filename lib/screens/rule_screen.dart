import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📜 Règles du jeu - La Garame"),
        backgroundColor: Colors.green[900],
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/table1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.black.withOpacity(0.6),
          child: ListView(
            children: [
              const Text(
                "🎯 Objectif du jeu",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Remporter le plus de plis en jouant des cartes de valeur supérieure dans la même famille que celle demandée.",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                "🃏 Déroulement d'une partie",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "• Chaque joueur commence avec 5 cartes.\n"
                "• Le premier joueur pose une carte, les autres doivent jouer une carte de la même famille si possible.\n"
                "• Celui qui joue la carte de plus haute valeur dans la famille demandée remporte le pli.\n"
                "• Le vainqueur du pli commence le tour suivant.\n"
                "• Quand tous les plis sont joués, le joueur avec le plus de plis remportés gagne la partie.",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                "⚠️ Règles spéciales",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "• Si un joueur ne possède pas de carte de la famille demandée, il peut jouer n'importe quelle carte, mais ne remportera pas le pli.\n"
                "• Les cartes vont de 3 à 9.\n"
                "• Il est essentiel de suivre la famille si on en a dans sa main.",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Retour"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
