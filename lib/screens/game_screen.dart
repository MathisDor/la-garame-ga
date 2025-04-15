// Created by: Mathis Dorian
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/card.dart';
import '../models/player.dart';
import '../providers/game_provider.dart';
import '../widgets/card_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Map<String, dynamic>> _playedCards = [];
  Player? _roundWinner;
  Player? _gameWinner;
  String? _leadFamily;

  @override
  Widget build(BuildContext context) {
    final numberOfAI = ModalRoute.of(context)?.settings.arguments as int? ?? 1;
    final gameProvider = Provider.of<GameProvider>(context);

    if (_gameWinner != null) {
      return _buildGameOverScreen(context);
    }

    return WillPopScope(
      onWillPop: () async {
        _resetGame(gameProvider);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Partie contre $numberOfAI IA'),
          backgroundColor: Colors.green[900],
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _resetGame(gameProvider),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/table1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Consumer<GameProvider>(
            builder: (context, game, child) {
              if (!game.isGameStarted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  game.initializeGame(numberOfAI, cardsPerPlayer: 5);
                });
                return const Center(child: CircularProgressIndicator());
              }

              final humanPlayer = game.players.firstWhere((p) => p.isHuman);
              final aiPlayers = game.players.where((p) => !p.isHuman).toList();

              if (_checkGameOver(game)) {
                _gameWinner = _determineWinner(game);
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => setState(() {}));
              }

              return Stack(
                children: [
                  ..._buildAIHands(context, aiPlayers, game),
                  _buildPlayedCards(),
                  _buildHumanHand(humanPlayer, game),
                  if (_roundWinner != null) _buildRoundWinnerMessage(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ----- GAME LOGIC -----

  bool _checkGameOver(GameProvider game) {
    return game.players.every((p) => p.hand.isEmpty);
  }

  Player? _determineWinner(GameProvider game) {
    return game.players.reduce((a, b) => a.score > b.score ? a : b);
  }

  void _playCard(Player player, GameProvider game, PlayingCard card) {
    setState(() {
      _playedCards.add({'player': player, 'card': card});
      _leadFamily ??= card.suit;
    });

    game.playCard(player, card);
    player.removeFromHand(card);
    game.currentPlayerIndex =
        (game.currentPlayerIndex + 1) % game.players.length;

    if (game.currentPlayerIndex < 0 ||
        game.currentPlayerIndex >= game.players.length) {
      game.currentPlayerIndex = 0; // Correction pour éviter un blocage du tour
    }

    if (_playedCards.length == game.players.length) {
      _endRound(game);
    } else if (!game.players[game.currentPlayerIndex].isHuman) {
      Future.delayed(
          const Duration(milliseconds: 500), () => _playAITurn(game));
    }
  }

  void _playAITurn(GameProvider game) {
    if (game.currentPlayerIndex == 0 || _gameWinner != null) return;

    Future.delayed(const Duration(seconds: 2), () {
      final aiPlayer = game.players[game.currentPlayerIndex];
      final possibleCards = aiPlayer.hand.where(_canPlayCard).toList();
      final card = possibleCards.isNotEmpty
          ? possibleCards.reduce((a, b) => a.value > b.value ? a : b)
          : aiPlayer.hand.first;

      _playCard(aiPlayer, game, card);
    });
  }

  void _endRound(GameProvider game) {
    final validPlays =
        _playedCards.where((e) => e['card'].suit == _leadFamily).toList();
    validPlays.sort((a, b) => b['card'].value.compareTo(a['card'].value));
    final winner = validPlays.first['player'] as Player;

    
    _roundWinner = winner;

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _playedCards.clear();
        _roundWinner = null;
        _leadFamily = null;
        game.currentPlayerIndex = game.players.indexOf(winner);
      });

      if (!game.players.every((p) => p.hand.isEmpty)) {
        _playAITurn(game);
      }
    });
  }

  bool _canPlayCard(PlayingCard card) {
    if (_leadFamily == null) return true;

    final sameFamilyCards =
        _playedCards.where((e) => e['card'].suit == _leadFamily);
    if (sameFamilyCards.isEmpty) return true;

    final maxVal = sameFamilyCards
        .map((e) => e['card'].value)
        .reduce((a, b) => a > b ? a : b);
    return card.suit == _leadFamily && card.value > maxVal;
  }

  void _resetGame(GameProvider game) {
    game.isGameStarted = false;
    _playedCards.clear();
    _roundWinner = null;
    _gameWinner = null;
    _leadFamily = null;
  }

  // ----- UI WIDGETS -----

  Widget _buildGameOverScreen(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.blueGrey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events_rounded,
                  size: 80, color: Colors.amberAccent),
              const SizedBox(height: 20),
              Text(
                '${_gameWinner?.name ?? 'Personne'} a gagné la partie !',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        blurRadius: 10,
                        color: Colors.black45,
                        offset: Offset(2, 2)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Rejouer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent.shade700,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  _resetGame(Provider.of<GameProvider>(context, listen: false));
                  setState(() {
                    _gameWinner = null;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                icon: const Icon(Icons.home, color: Colors.white70),
                label: const Text(
                  'Retour à l\'accueil',
                  style: TextStyle(color: Colors.white70),
                ),
                onPressed: () {
                  _resetGame(Provider.of<GameProvider>(context, listen: false));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundWinnerMessage() {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${_roundWinner?.name} remporte le pli !',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAIHands(
      BuildContext context, List<Player> aiPlayers, GameProvider game) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return List.generate(aiPlayers.length, (i) {
      double left = 0;
      double top = 0;

      if (i == 0) {
        left = screenWidth / 2 - 30;
        top = 30;
      } else if (i == 1) {
        left = screenWidth - 150;
        top = screenHeight / 2 - 50;
      } else if (i == 2) {
        left = 100;
        top = screenHeight / 2 - 50;
      }

      return Positioned(
        left: left,
        top: top,
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: game.currentPlayerIndex == i + 1
                  ? Colors.amber
                  : Colors.blueGrey[800],
              child: Text(aiPlayers[i].name,
                  style: const TextStyle(fontSize: 10, color: Colors.white)),
            ),
            const SizedBox(height: 10),
            Text('${aiPlayers[i].hand.length} cartes',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
      );
    });
  }

  Widget _buildPlayedCards() {
    return Center(
      child: Wrap(
        spacing: 10,
        alignment: WrapAlignment.center,
        children: _playedCards.map((entry) {
          return CardWidget(
            card: entry['card'],
            width: 80,
            height: 120,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHumanHand(Player player, GameProvider game) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 400),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: player.hand.length,
                itemBuilder: (context, index) {
                  final card = player.hand[index];
                  final canPlay =
                      game.currentPlayerIndex == 0 && _canPlayCard(card);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CardWidget(
                      card: card,
                      isPlayable: canPlay,
                      onTap:
                          canPlay ? () => _playCard(player, game, card) : null,
                      width: 100,
                      height: 100,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
