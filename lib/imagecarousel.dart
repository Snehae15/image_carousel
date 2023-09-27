import 'package:flutter/material.dart';
import 'package:image_carousel/firstpage.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final List<String> images = [
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg',
  ];

  PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = (_pageController.page ?? 0.0) - index.toDouble();
                    value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                  }

                  return Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FutureBuilder(
        future:
            Future.delayed(Duration.zero), // Defer execution until after build
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildFloatingActionButton();
          } else {
            return SizedBox.shrink(); // Hide the button while waiting
          }
        },
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    if (_pageController.page == 0) {
      // Show the "Skip" button on the first page
      return FloatingActionButton(
        onPressed: () {
          // Navigate to another page (replace with your navigation logic)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Firstpage(),
            ),
          );
        },
        child: Icon(Icons.skip_next),
      );
    } else if (_pageController.page == images.length - 1) {
      // Show the "Skip" button on the last page
      return FloatingActionButton(
        onPressed: () {
          // Navigate to another page (replace with your navigation logic)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Firstpage(),
            ),
          );
        },
        child: Icon(Icons.skip_next),
      );
    } else {
      // Hide the button on other pages
      return SizedBox.shrink();
    }
  }
}
