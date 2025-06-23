import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:klondlike/klondike_game.dart';

@immutable
class Suit {
  bool get isRed => value <= 1;
  bool get isBlack => value >= 2;

  final int value;
  final String label;
  final Sprite sprite;
  factory Suit.fromInt(int index) {
    assert(
      index >= 0 && index <= 3,
      'index is outside of the bounds of what a suit can be',
    );
    return _singletons[index];
  }
  Suit._(this.value, this.label, double x, double y, double w, double h)
    : sprite = klondlikeSprite(x: x, y: y, height: h, width: w);
  static final List<Suit> _singletons = [
    Suit._(0, '♥', 1176, 17, 172, 183),
    Suit._(1, '♦', 973, 14, 177, 182),
    Suit._(2, '♣', 974, 226, 184, 172),
    Suit._(3, '♠', 1178, 220, 176, 182),
  ];
}
