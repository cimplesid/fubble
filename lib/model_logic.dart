import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Bubble {
  Color colour;
  double direction;
  double speed;
  double radius;
  double x;
  double y;
  String animation;
  String gesture;

  Bubble(Color colour, double maxBubbleSize, double speed) {
    this.colour = colour.withOpacity(Random().nextDouble());
    this.direction = Random().nextDouble() * 360;
    this.speed = speed;
    this.radius = Random().nextDouble() * maxBubbleSize;
    this.animation = animation;
    this.gesture = gesture;
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = new Paint()
      ..color = colour
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    defineOffsetCoordinateInitially(canvasSize);

    shiftTheOreintationIfCanvasBorderReached(canvasSize);

    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  void defineOffsetCoordinateInitially(Size canvasSize) {
    if (x == null) {
      this.x = Random().nextDouble() * canvasSize.width;
    }

    if (y == null) {
      this.y = Random().nextDouble() * canvasSize.height;
    }
  }
//add the bubble animation here
  changeThePosition(String animation) {
    switch (animation) {
      case "Default":
        {
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / sin(speed)
              : x = x - speed * sin(direction) / sin(speed);
          direction > 90 && direction < 270
              ? y += speed * sin(direction) / sin(speed)
              : y -= speed * sin(direction) / sin(speed);
        }
        break;
      case "WallBreaker":
        {
          var angle = 180 - (direction + 90);
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / sin(speed) * pi
              : x = x - speed * sin(direction) / sin(speed) * pi;
          direction > 90 && direction < 270
              ? y += speed * sin(angle) / sin(speed)
              : y -= speed * sin(angle) / sin(speed);
        }
        break;
      case "OnWeed":
        {
          var angle = 180 - (direction + 90);
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / (sin(speed) * pi)
              : x = x - speed * sin(direction) / (sin(speed) * pi);
          direction > 90 && direction < 270
              ? y += speed * sin(angle) / (sin(speed) * pi)
              : y -= speed * sin(angle) / (sin(speed) * pi);
        }
        break;
      case "Goodnbad":
        {
          var angle = 180 - (direction + 90);
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / (sin(speed) * pi)
              : x = x - speed * sin(direction) / (sin(speed) * pi);
          direction > 90 && direction < 270
              ? y += direction * sin(angle) / (sin(speed) * pi)
              : y -= speed * sin(angle) / (sin(speed) * pi);
        }
        break;
      case "Battle":
        {
          var angle = 180 - (direction + 90);
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / (sin(speed) * pi)
              : x = x - speed * sin(direction) / (sin(speed) * pi);
          direction > 90 && direction < 270
              ? y += direction * sin(angle) / (sin(speed) * pi)
              : y -= direction * sin(angle) / (sin(speed) * pi);
        }
        break;
      case "Rain":
        {
          //travelling wave : surface problem
          var angle = 180 - (direction + 90);
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / (sin(speed) * pi)
              : x = x - speed * sin(direction) / (sin(speed) * pi);
          direction > 90 && direction < 270
              ? y += speed * sin(angle) / sin(speed)
              : y -= speed * sin(angle) / sin(speed);
        }
        break;
      default:
        {
          direction > 0 && direction < 180
              ? x = x + speed * sin(direction) / sin(speed)
              : x = x - speed * sin(direction) / sin(speed);
          direction > 90 && direction < 270
              ? y += speed * sin(direction) / sin(speed)
              : y -= speed * sin(direction) / sin(speed);
        }
        break;
    }
  }
//add the  gesture here
  onDraw(Offset _localPosition, Bubble bubble, BuildContext context,
      String gesture) {
    switch (gesture) {
      case "Default":
        {
          double diffx = _localPosition.dx - bubble.x;
          double diffy = _localPosition.dy - bubble.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);

          if (dist < 60) {
            diffx = diffx * 60 / dist;
            diffy = diffy * 60 / dist;
            bubble.x = diffx + _localPosition.dx;
            bubble.y = diffy + _localPosition.dy;
          }
        }
        break;
      case "CenterBlast":
        {

          double diffx = _localPosition.dx - bubble.x;
          double diffy = _localPosition.dy - bubble.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          if (dist < 60) {
            bubble.x = width / 2;
            bubble.y = height / 2;
          }
        }
        break;
      case "Dart":
        {
          double diffx = _localPosition.dx - bubble.x;
          double diffy = _localPosition.dy - bubble.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);

          if (dist < 60) {
            bubble.x = 0;
            bubble.y = 0;
          }
        }
        break;
      case "Attract":
        {
          double diffx = _localPosition.dx - bubble.x;
          double diffy = _localPosition.dy - bubble.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);

          if (dist < 60) {
            bubble.x = _localPosition.dx;
            bubble.y = _localPosition.dy;
          }
        }
        break;
      case "Eraser":
        {
          double diffx = _localPosition.dx - bubble.x;
          double diffy = _localPosition.dy - bubble.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);

          if (dist < 60) {
            diffx = diffx * 60 / dist;
            diffy = diffy * 60 / dist;
            bubble.x = diffx;
            bubble.y = diffy;
          }
        }
        break;
      default:
        {

          double diffx = _localPosition.dx - bubble.x;
          double diffy = _localPosition.dy - bubble.y;
          double dist = sqrt(diffx * diffx + diffy * diffy);

          if (dist < 60) {
            diffx = diffx * 60 / dist;
            diffy = diffy * 60 / dist;
            bubble.x = diffx + _localPosition.dx;
            bubble.y = diffy + _localPosition.dy;
          }
        }
        break;
    }
  }

  shiftTheOreintationIfCanvasBorderReached(Size canvasSize) {
    if (x >= canvasSize.width || x < 0 || y >= canvasSize.height || y < 0) {
      direction = Random().nextDouble() * 360;
    }
  }
}
