import 'package:flutter/material.dart';
import '../models/card.dart';

class CardWidget extends StatelessWidget {
  final PlayingCard card;
  final bool isPlayable;
  final VoidCallback? onTap;
  final double width;
  final double height;

  const CardWidget({
    super.key,
    required this.card,
    this.isPlayable = false,
    this.onTap,
    this.width = 80,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isPlayable ? const Color.fromARGB(255, 7, 85, 255) : Colors.white,
            width: isPlayable ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: card.isFaceUp ? _buildCardFace() : _buildCardBack(),
      ),
    );
  }

  Widget _buildCardFace() {
    final cardImagePath = 'assets/images/cards/${card.value}${card.suit}.png';
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(cardImagePath),
          fit: BoxFit.cover,
          onError: (_, __) => _buildFallbackCard(),
        ),
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[900],
        image: const DecorationImage(
          image: AssetImage('assets/images/dos.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildFallbackCard() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              card.displayValue,
              style: TextStyle(
                fontSize: width * 0.25,
                fontWeight: FontWeight.bold,
                color: _getTextColor(),
              ),
            ),
            Text(
              card.suitSymbol,
              style: TextStyle(
                fontSize: width * 0.3,
                color: _getTextColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTextColor() {
    return card.suit == 'coeur' || card.suit == 'carreau'
        ? Colors.red[700]!
        : Colors.black;
  }
}