# 🃏 La Garame – Jeu de cartes multijoueur en Flutter

> _La Garame_ est un jeu de cartes stratégique inspiré des jeux africains traditionnels, développé en Flutter. Jusqu’à 5 joueurs peuvent s’affronter autour de règles simples mais exigeantes, avec une interface intuitive et dynamique.

## 🚀 Fonctionnalités

- Distribution aléatoire des cartes (valeurs de 3 à 9)
- Interface avec une zone de jeu centrale
- Tour par tour : chaque joueur joue une carte par manche
- Détection automatique du gagnant d’un tour
- Gestion partielle de l'IA (en développement)

## 🎮 Règles du jeu

- Chaque joueur commence avec 5 cartes.
- Le joueur qui reçoit la première carte commence.
- Les autres doivent jouer une carte de la **même famille**, de valeur **supérieure** pour prendre la main.
- Si un joueur joue une carte de valeur inférieure ou différente, l’adversaire garde la main.
- Le gagnant d’un tour est celui qui a joué la carte de la **même famille** la **plus élevée**.
- Le jeu continue jusqu'à épuisement des cartes.
- Le **gagnant final** est déterminé à la dernière manche.

## 🧠 IA

- Une IA simple commence à être intégrée
- À terme : stratégie évolutive pour chaque joueur non humain

## 🛠️ Technologies utilisées

- [Flutter](https://flutter.dev/) – UI rapide, multi-plateforme
- Dart – Langage principal
- Architecture MVC simplifiée
- Prévue pour évoluer avec Bloc ou Provider

## 📅 Roadmap

- [x] Distribution des cartes
- [x] Interface utilisateur de base
- [x] Logique de tour simple
- [ ] IA complète
- [ ] Multijoueur (local et en ligne)
- [ ] Système de points et tableau des scores

## 📸 Aperçu

*(à venir avec captures d'écran ou vidéo du gameplay)*

## 🔄 Contribution

Les contributions sont les bienvenues ! Clone, fork, propose une PR 😉

---

> Fait avec ❤️ par Mathis  
> Projet personnel développé pour apprendre Flutter et partager une passion pour les jeux de cartes traditionnels.
