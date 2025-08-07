import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grabit/features/home/view/widgets/cached_viewer.dart';
import '../../model/banner_model.dart';

class HeroBanner extends StatefulWidget {
  final List<AppBannerModel> banners;

  const HeroBanner({super.key, required this.banners});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (widget.banners.isEmpty) return const SizedBox();


    return SizedBox(
      width: screenWidth,
      height: screenHeight *0.12,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Carousel Image
          Stack(
            children: [
              CarouselSlider.builder(
                itemCount: widget.banners.length,
                itemBuilder: (context, index, _) {
                  final banner = widget.banners[index];
                  return Container(
                    width: screenWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [

CachedImageViewer(
  imageUrl: banner.imageUrl,
  width: screenWidth,
  fit: BoxFit.cover,
),
Align(
  alignment: Alignment.center,
  child: Text(banner.title.split('- ').last,style: GoogleFonts.labrada(),))



                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: screenHeight * (100 / 786.7),
                  viewportFraction: 1.0,
                  autoPlay: true,
                  onPageChanged: (index, _) {
                    setState(() => _current = index);
                  },
                ),
              ),
             
            ],
          ),
          
      
          // Dot Indicator at Top Center
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom:  8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.banners.asMap().entries.map((entry) {
                  return Container(
                    width: _current == entry.key ? 10.0 : 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 199, 199, 199),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
