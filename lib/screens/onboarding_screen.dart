import 'package:donor_mobile_app/models/onboarding_model.dart';
import 'package:donor_mobile_app/screens/auth/index_screen.dart';
import 'package:donor_mobile_app/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  final Color brandRed = const Color(0xFFE53935);

  final List<OnboardPageData> pages = [
    OnboardPageData(
      title: 'Find Blood Donors',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Arcu tristique tristique quam in.',
      image: 'assets/images/icon.svg',
      isNetwork: true,
    ),
    OnboardPageData(
      title: 'Post A Blood Request',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Arcu tristique tristique quam in.',
      image: 'assets/images/icon2.svg ',
      isNetwork: true,
    ),
  ];

  bool get _isLast => _currentPage == pages.length - 1;

  void _goNext() {
    if (_isLast) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthIndexPage()),
      );
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _skipToEnd() {
    _controller.animateToPage(
      pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            children: [
              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      data: pages[index],
                      index: index,
                      currentIndex: _currentPage,
                      total: pages.length,
                      activeColor: brandRed,
                    );
                  },
                ),
              ),

              // Bottom Bar
              SizedBox(
                height: size.height * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _skipToEnd,
                      child: const Text('Skip'),
                    ),
                    TextButton(
                      onPressed: _goNext,
                      child: Text(
                        _isLast ? 'Start' : 'Next',
                        style: TextStyle(color: brandRed),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
