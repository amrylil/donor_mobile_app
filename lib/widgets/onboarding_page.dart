import 'package:donor_mobile_app/models/onboarding_model.dart';
import 'package:donor_mobile_app/widgets/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardPageData data;
  final int index;
  final int currentIndex;
  final int total;
  final Color activeColor;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.index,
    required this.currentIndex,
    required this.total,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 48),

          // Gambar
          AspectRatio(
            aspectRatio: 1.1,
            child: data.isNetwork
                ? SvgPicture.asset(data.image, fit: BoxFit.contain)
                : SvgPicture.asset(data.image, fit: BoxFit.contain),
          ),
          const SizedBox(height: 28),

          // Judul
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 28),

          // Deskripsi
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 44),

          // Dots
          DotsIndicator(
            length: total,
            index: currentIndex,
            activeColor: activeColor,
          ),
        ],
      ),
    );
  }
}
