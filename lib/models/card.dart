// lib/models/card.dart


class PlayingCard {
  final int value; // 3 à 10
  final String suit; // 'coeur', 'carreau', 'trefle', 'pique'
  bool isFaceUp;

  PlayingCard({
    required this.value,
    required this.suit,
    this.isFaceUp = true,
  });

  // Getter pour la valeur affichée
  String get displayValue => value.toString();

  // Getter pour le symbole de la famille
  String get suitSymbol {
    switch(suit) {
      case 'coeur': return '♥';
      case 'carreau': return '♦';
      case 'trefle': return '♣';
      case 'pique': return '♠';
      default: return '';
    }
  }

  // Getter pour le nom complet de la famille
  String get suitName {
    switch(suit) {
      case 'coeur': return 'Cœur';
      case 'carreau': return 'Carreau';
      case 'trefle': return 'Trèfle';
      case 'pique': return 'Pique';
      default: return 'Inconnu';
    }
  }

  @override
  String toString() => '$displayValue$suitSymbol';

  // Pour la comparaison des cartes
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      other is PlayingCard &&
      runtimeType == other.runtimeType &&
      value == other.value &&
      suit == other.suit;
  }

  @override
  int get hashCode => value.hashCode ^ suit.hashCode;

  // Méthode pour retourner la carte
  PlayingCard flip() => PlayingCard(
    value: value,
    suit: suit,
    isFaceUp: !isFaceUp,
  );
  PlayingCard copyWith({
  int? value,
  String? suit,
  bool? isFaceUp,
}) {
  return PlayingCard(
    value: value ?? this.value,
    suit: suit ?? this.suit,
    isFaceUp: isFaceUp ?? this.isFaceUp,
  );
}
}