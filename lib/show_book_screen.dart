import 'package:animated_book_widget/animated_book_widget.dart';
import 'package:flutter/material.dart';

enum AnimatedBookStatus { dismissed, completed }

class MagazineExample extends StatefulWidget {
  const MagazineExample({
    required this.horizontalView,
    super.key,
  });

  final bool horizontalView;

  @override
  _MagazineExampleState createState() => _MagazineExampleState();
}

class _MagazineExampleState extends State<MagazineExample> {
  // List of magazine pages (URLs)
  List<String> magazinePages = [
    'https://content.wepik.com/statics/90897927/preview-page0.jpg',
    'https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg',
    'https://i.pinimg.com/originals/a1/f8/87/a1f88733921c820db477d054fe96afbb.jpg',
  ];

  AnimatedBookStatus status = AnimatedBookStatus.completed;
  late PageController
      _pageController; // Page controller for navigating through pages

  Size get heightSize => const Size.fromHeight(225);

  Size get widthSize => const Size.fromWidth(160);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Initialize the PageController
  }

  void updateStatus() {
    setState(() {
      status = status == AnimatedBookStatus.completed
          ? AnimatedBookStatus.dismissed
          : AnimatedBookStatus.completed; // Toggle the status
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: updateStatus,
        child: AnimatedBookWidget(
          size: widget.horizontalView ? widthSize : heightSize,
          padding: widget.horizontalView
              ? const EdgeInsets.symmetric(horizontal: 5)
              : const EdgeInsets.symmetric(vertical: 5),
          cover: ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(10)),
            child: Image.network(
              magazinePages[0], // Display the first page as the cover
              fit: BoxFit.cover,
            ),
          ),
          content: SizedBox(
            width: widget.horizontalView ? widthSize.width : heightSize.width,
            height:
                widget.horizontalView ? heightSize.height : widthSize.height,
            child: PageView.builder(
              controller: _pageController, // Use the PageController
              itemCount: magazinePages.length,
              itemBuilder: (context, pageIndex) {
                return GestureDetector(
                  onTap: () {
                    // Update the status for flipping
                    updateStatus();
                  },
                  child: ColoredBox(
                    color: const Color(0xFFF1F1F1),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.network(
                        magazinePages[pageIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
