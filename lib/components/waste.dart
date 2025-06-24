import 'package:flame/components.dart';
import 'package:klondlike/components/card.dart';
import 'package:klondlike/klondike_game.dart';

class WastePile extends PositionComponent {
  WastePile({super.position}) : super(size: KlondikeGame.cardSize);
  @override
  bool get debugMode => true;
  final List<Card> _cards = [];
  final Vector2 _fanOffset = Vector2(KlondikeGame.cardWidth * 0.2, 0);
  void acquireCard(Card card) {
    assert(card.isFaceUp);
    card.position = position;
    card.priority = priority;
    _cards.add(card);
  }

  void fanOutTopCard() {
    final n = _cards.length;
    for (var i = 0; i <= n; i++) {
      _cards[i].position = position;
    }
    if (n == 2) {
      _cards[1].position.add(_fanOffset);
    } else if (n >= 3) {
      _cards[n - 2].position.add(_fanOffset);
      _cards[n - 1].position.addScaled(_fanOffset, 2);
    }
  }

  List<Card> removeAllCards() {
    final cards = _cards.toList();
    _cards.clear();
    return cards;
  }
}
