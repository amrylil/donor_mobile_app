import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

// Daftar gambar Anda (tetap sama)
final List<String> imgList = [
  'https://i.pinimg.com/1200x/a8/bc/16/a8bc16135c4752c9274f4c4e7177c31f.jpg',
  'https://i.pinimg.com/736x/6b/6c/ce/6b6cceb500faaab6a48a0d419b75f117.jpg',
  'https://i.pinimg.com/1200x/10/0a/a0/100aa0a6d585ef0e479ff95c325feac7.jpg',
];

class MyImageCarousel extends StatelessWidget {
  const MyImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. HAPUS SizedBox agar lebarnya tidak terbatas
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          imgList[index],
          fit: BoxFit.cover, // BoxFit.cover akan mengisi seluruh area
        );
      },
      itemCount: imgList.length,
      autoplay: true,
      pagination: const SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: Colors.grey,
          activeColor: Colors.red,
        ),
      ),
      // 2. UBAH DUA BARIS INI
      viewportFraction: 1.0, // <-- Agar satu item memenuhi lebar
      scale: 1.0, // <-- Agar tidak ada efek scaling
    );
  }
}
