import 'dart:ui';

import 'package:flutter/material.dart';

class BackGroundElements extends StatelessWidget {
  const BackGroundElements({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(3, -0.3),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.deepPurple),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-3, -0.3),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.deepPurple),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, -1.8),
          child: Container(
            height: 300,
            width: 500,
            decoration: const BoxDecoration(color: Color(0xFFFFAB40)),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
