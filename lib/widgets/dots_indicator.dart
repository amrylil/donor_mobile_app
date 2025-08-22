import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int length;
  final int index;
  final Color activeColor;

  const DotsIndicator({
    super.key,
    required this.length,
    required this.index,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        final bool active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 22 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: active ? activeColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}
