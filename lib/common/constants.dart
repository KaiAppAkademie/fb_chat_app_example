import 'dart:ui';

const Map<String, Color> userColors = {
  'lukas@aa.de': Color(0xFFEB3AFF),
  'angi@aa.de': Color(0xFF55FF4F),
  'david@aa.de': Color(0xFFFE454E),
  'kai@aa.de': Color(0xFFDCD631),
};

const Color bubbleDefaultColor = Color(0xFF1B97F3);

Color colorForUser(String userName) =>
    userColors[userName] ?? bubbleDefaultColor;
