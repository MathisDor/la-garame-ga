// lib/models/player.dart
import 'card.dart';  // Chemin corrigé en minuscules

class Player {
  final String id;
  final String name;
  final bool isHuman;
  List<PlayingCard> hand;
  int score = 0;  // Ajout d'un score pour le joueur

  Player({
    required this.id,
    required this.name,
    this.isHuman = false,
    List<PlayingCard>? hand,  // Utilisation d'un paramètre optionnel
  }) : hand = hand ?? [];     // Initialisation avec opérateur null-coalescing

  // Ajoute une carte à la main
  void addToHand(PlayingCard card) {
    hand.add(card);
  }

  // Retire une carte spécifique
  void removeFromHand(PlayingCard card) {
    hand.remove(card);  // Utilise l'opérateur == qu'on a implémenté dans PlayingCard
  }

  // Nouvelle méthode : compte le nombre de cartes d'une famille spécifique
  int countCardsBySuit(String suit) {
    return hand.where((card) => card.suit == suit).length;
  }

  // Nouvelle méthode : trie la main par valeur
  void sortHand() {
    hand.sort((a, b) => a.value.compareTo(b.value));
  }

  @override
  String toString() => '$name (${hand.length} cartes)';
}