import 'package:finora/core/constants.dart';
import 'package:finora/presentation/home/widgets/bottom_custome_app_bar_clipper.dart';
import 'package:flutter/material.dart';

class BotttomCustomeAppBar extends StatelessWidget {
  final int currentIndex;

  const BotttomCustomeAppBar({super.key, required this.currentIndex});
  @override
  Widget build(BuildContext context) {
    const double circuleRadius = 15;

    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Stack(
        children: [
          const CustomeBottomBarShadow(),
          ClipPath(
            clipper: const BottomCustomeAppBarClipper(),
            child: Container(
              height: 140,
              decoration: const BoxDecoration(
                color: kSecondColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(circuleRadius),
                  topRight: Radius.circular(circuleRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildItem(icon: Icons.home, index: 0, onTap: (value) {}),
                    _buildItem(icon: Icons.search, index: 1, onTap: (value) {}),

                    const SizedBox(width: 40),

                    _buildItem(icon: Icons.money, index: 2, onTap: (value) {}),
                    _buildItem(icon: Icons.person, index: 3, onTap: (value) {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required int index,
    required ValueChanged<int> onTap,
  }) {
    return IconButton(
      onPressed: () => onTap(index),
      icon: Icon(
        icon,
        color: currentIndex == index ? kPrimaryColor : Colors.grey,
        size: 30,
      ),
    );
  }
}

class CustomeBottomBarShadow extends StatelessWidget {
  const CustomeBottomBarShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClipperShadowPainter(
        clipper: const BottomCustomeAppBarClipper(),
        shadow: const Shadow(blurRadius: blurRadius, color: Colors.grey),
      ),
      child: const SizedBox(height: 140, width: double.infinity),
    );
  }
}

class ClipperShadowPainter extends CustomPainter {
  final CustomClipper<Path> clipper;
  final Shadow shadow;

  ClipperShadowPainter({required this.clipper, required this.shadow});

  @override
  void paint(Canvas canvas, Size size) {
    final path = clipper.getClip(size);

    final paint = shadow.toPaint();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
