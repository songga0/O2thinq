import 'package:flutter/material.dart';

class CleanerBottom extends StatelessWidget {
  const CleanerBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -1,
          child: Transform.rotate(
            angle: 1.57,
            child: Container(
              width: 41,
              height: 24,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34.5),
                ),
              ),
            ),
          ),
        ),
        Transform.rotate(
          angle: 1.57,
          child: Container(
            width: 39,
            height: 22,
            decoration: ShapeDecoration(
              color: const Color(0xFF6C6C6C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(34.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Cleaner extends StatelessWidget {
  const Cleaner({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 1,
      child: Transform.rotate(
      angle: 1.57, // 90도 회전 (라디안)
      child: Container(
        width: 35,
        height: 16,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34.5),
          ),
        ),
      ),
    ),);
  }
}

class CleanerTop extends StatelessWidget {
  const CleanerTop({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24, // 또는 충분히 큰 높이, 예: 30~40
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -12,
            child: Container(
              width: 24,
              height: 24,
              decoration: const ShapeDecoration(
                color: Color(0xFFF3F3F3),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            top: -10,
            child: Transform.rotate(
              angle: 1.57,
              child: Container(
                width: 9,
                height: 24,
                decoration: const ShapeDecoration(
                  color: Color(0xFFF3F3F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -5,
            child: Container(
              width: 24,
              height: 24,
              decoration: const ShapeDecoration(
                color: Color(0xFFE8E8E8),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            top: -2,
            child: Container(
              width: 24,
              height: 24,
              decoration: ShapeDecoration(
                color: const Color(0xFF6C6C6C).withOpacity(0.3),
                shape: const OvalBorder(),
              ),
            ),
          ),
          Positioned(
            top: -4,
            child: Container(
              width: 24,
              height: 24,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
