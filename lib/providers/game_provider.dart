import 'dart:math';

import 'package:flutter/material.dart';
import '../models/card.dart';
import '../models/player.dart';

class GameProvider with ChangeNotifier {
  List<Player> players = [];
  List<PlayingCard> deck = [];
  String? currentSuit;
  PlayingCard? highestCard;
  int currentPlayerIndex = 0;
  bool isGameStarted = false;
  int currentPot = 0;
  int roundStarterIndex = 0;

  List<Player> getTurnOrder() {
    return List.generate(players.length, (i) {
      final index = (roundStarterIndex + i) % players.length;
      return players[index];
    });
  }

  void initializeGame(int numberOfAI, {int cardsPerPlayer = 5}) {
    _createDeck();

    players = [
      Player(id: 'player1', name: 'Vous', isHuman: true),
      ...List.generate(numberOfAI,
          (index) => Player(id: 'ai${index + 1}', name: 'IA ${index + 1}')),
    ];

    _dealCards(cardsPerPlayer);
    isGameStarted = true;
    currentPot = 0;
    currentPlayerIndex = 0;
    currentSuit = null;
    highestCard = null;
    roundStarterIndex = 0;

    notifyListeners();
  }

  void _createDeck() {
    deck = [];
    const suits = ['coeur', 'pique', 'carreau', 'trefle'];

    for (var suit in suits) {
      for (int value = 3; value <= 9; value++) {
        deck.add(PlayingCard(value: value, suit: suit));
      }
    }

    deck.shuffle();
  }

  void _dealCards(int cardsPerPlayer) {
    final totalCards = cardsPerPlayer * players.length;
    if (deck.length < totalCards) {
      throw Exception("Pas assez de cartes dans le deck");
    }

    for (var player in players) {
      player.hand = deck.sublist(0, cardsPerPlayer).map((card) {
        return player.isHuman ? card.copyWith(isFaceUp: true) : card;
      }).toList();
      deck.removeRange(0, cardsPerPlayer);
    }
  }

  void playCard(Player player, PlayingCard card) {
    if (currentSuit == null) {
      currentSuit = card.suit;
      highestCard = card;
    } else if (card.suit == currentSuit && card.value > highestCard!.value) {
      highestCard = card;
    }

    player.removeFromHand(card);
    _nextPlayer();
    notifyListeners();
  }

  void _nextPlayer() {
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
    print('Index actuel du joueur : $currentPlayerIndex');

    if (currentPlayerIndex == 0) {
      _endRound();
    }
  }

  void _endRound() {
    final winner = players.firstWhere(
        (player) => player.hand.any((card) => card == highestCard),
        orElse: () => players[roundStarterIndex]);

  
    roundStarterIndex = players.indexOf(winner);
    
    currentSuit = null;
    highestCard = null;
    currentPlayerIndex = roundStarterIndex;
    
    print('Gagnant du tour : ${winner.name}');
    notifyListeners();
  }
}
