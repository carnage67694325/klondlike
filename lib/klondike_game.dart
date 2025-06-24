import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:klondlike/components/card.dart';
import 'package:klondlike/components/foundation.dart';
import 'package:klondlike/components/pile.dart';
import 'package:klondlike/components/stock.dart';
import 'package:klondlike/components/waste.dart';

class KlondikeGame extends FlameGame {
  static const double cardWidth = 1000.0;
  static const double cardHeight = 1400.0;
  static const double cardGap = 175.0;
  static const double cardRadius = 100.0;
  static final Vector2 cardSize = Vector2(cardWidth, cardHeight);
  static final cardRRect = RRect.fromRectAndRadius(
    const Rect.fromLTWH(0, 0, cardWidth, cardHeight),
    const Radius.circular(cardRadius),
  );

  @override
  Future<void> onLoad() async {
    await Flame.images.load(sprite);
    StockPile stock = initStock();
    WastePile waste = initWaste();
    List<FoundationPile> foundations = initFoundations();
    List<Pile> piles = initPiles();
    addingComponentsToGameWorld(stock, waste, foundations, piles);
    initCameraViewFinder();
    addingCardsToStock(stock);
  }

  void addingCardsToStock(StockPile stock) {
    final cards = [
      for (var rank = 1; rank <= 13; rank++)
        for (var suit = 1; suit < 4; suit++) Card(rank, suit),
    ];
    cards.shuffle();
    world.addAll(cards);
    cards.forEach(stock.acquireCard);
  }

  List<Pile> initPiles() {
    final piles = List.generate(
      7,
      (i) => Pile()
        ..size = cardSize
        ..position = Vector2(
          cardGap + i * (cardWidth + cardGap),
          cardHeight + 2 * cardGap,
        ),
    );
    return piles;
  }

  List<FoundationPile> initFoundations() {
    final foundations = List.generate(
      4,
      (i) => FoundationPile()
        ..size = cardSize
        ..position = Vector2(
          (i + 3) * (cardWidth + cardGap) + cardGap,
          cardGap,
        ),
    );
    return foundations;
  }

  WastePile initWaste() {
    final waste = WastePile()
      ..size = cardSize
      ..position = Vector2(cardWidth + 2 * cardGap, cardGap);
    return waste;
  }

  StockPile initStock() {
    final stock = StockPile()
      ..size = cardSize
      ..position = Vector2(cardGap, cardGap);
    return stock;
  }

  void addingComponentsToGameWorld(
    StockPile stock,
    WastePile waste,
    List<FoundationPile> foundations,
    List<Pile> piles,
  ) {
    world.add(stock);
    world.add(waste);
    world.addAll(foundations);
    world.addAll(piles);
  }

  void initCameraViewFinder() {
    camera.viewfinder.visibleGameSize = Vector2(
      cardWidth * 7 + cardGap * 8,
      4 * cardHeight + 3 * cardGap,
    );
    camera.viewfinder.position = Vector2(cardWidth * 3.5 + cardGap * 4, 0);
    camera.viewfinder.anchor = Anchor.topCenter;
  }
}

Sprite klondlikeSprite({
  required double x,
  required double y,
  required double width,
  required double height,
}) {
  return Sprite(
    Flame.images.fromCache(sprite),
    srcPosition: Vector2(x, y),
    srcSize: Vector2(width, height),
  );
}

String sprite = 'klondike-sprites.png';
