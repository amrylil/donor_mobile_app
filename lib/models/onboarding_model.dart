class OnboardPageData {
  final String title;
  final String description;
  final String image;
  final bool isNetwork;

  OnboardPageData({
    required this.title,
    required this.description,
    required this.image,
    this.isNetwork = true,
  });
}
