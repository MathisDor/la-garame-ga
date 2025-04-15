import 'dart:math';

import 'package:flutter/material.dart';
import '../models/player.dart';
import 'card_widget.dart';
import '../models/card.dart';

class PlayerWidget extends StatelessWidget {
  final Player player;
  final bool isCurrentPlayer;
  final bool showCards;
  final int cardsToShow;

  const PlayerWidget({
    super.key,
    required this.player,
    this.isCurrentPlayer = false,
    this.showCards = true,
    this.cardsToShow = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar du joueur
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isCurrentPlayer ? Colors.amber[600] : Colors.blueGrey[800],
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                player.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${player.hand.length} cartes',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        
        // Cartes du joueur
        if (showCards && player.hand.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              min(cardsToShow, player.hand.length),
              (_) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: CardWidget(
                  card: player.hand[0].isFaceUp 
                      ? player.hand[0] 
                      : PlayingCard(
                          value: 3,
                          suit: 'hearts',
                          isFaceUp: false,
                        ),
                  width: 40,
                  height: 60,
                ),
              ),
            ),
          ),
      ],
    );
  }
}