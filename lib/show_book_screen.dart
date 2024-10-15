import 'package:animated_book_widget/animated_book_widget.dart';
import 'package:book_animation/infrastructure/models/book_page_item.dart';
import 'package:flutter/material.dart';

class MagazineExample extends StatefulWidget {
  const MagazineExample({
    super.key,
  });

  @override
  _MagazineExampleState createState() => _MagazineExampleState();
}

class _MagazineExampleState extends State<MagazineExample>
    with TickerProviderStateMixin {
  List<BookPageItem> allPages = [];
  List<BookPageItem> currentPages = [];
  // List of magazine pages (URLs)
  List<String> urls = [
    'https://content.wepik.com/statics/90897927/preview-page0.jpg',
    'https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg',
    'https://i.pinimg.com/originals/a1/f8/87/a1f88733921c820db477d054fe96afbb.jpg',
  ];
  bool _isFirstTap = true;
  @override
  void initState() {
    initializePages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            Expanded(
                flex: 5,
                child: Container(
                  child: buildRecursive(),
                )),
            const SizedBox(
              height: 250,
            ),
          ],
        ),
      );

  Widget buildRecursive() => Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          ...buildPagesList(currentPages.toList()),
        ],
      );
  List<Widget> buildPagesList(List<BookPageItem> pages) => List.generate(
        pages.length,
        (index) => AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          top: 0,
          bottom: 0,
          // left: -(MediaQuery.of(context).size.width * 0.25),
          left: _isFirstTap ? -(MediaQuery.of(context).size.width * 0.25) : 0,
          right: _isFirstTap
              ? MediaQuery.of(context).size.width * 0.25
              : MediaQuery.of(context).size.width * 0.025,
          child: AnimatedBookWidget(
            totalPages: 5,
            size: Size.fromWidth(MediaQuery.of(context).size.width),
            // padding: widget.horizontalView
            //     ? const EdgeInsets.symmetric(horizontal: 5)
            //     : const EdgeInsets.symmetric(vertical: 5),
            cover: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(10), left: Radius.circular(10)),
              child: Image.network(
                urls[1],
                fit: BoxFit.cover,
              ),
            ),
            content: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(10), left: Radius.circular(10)),
              child: Image.network(
                urls[2],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );

  void initializePages() {
    for (String url in urls) {
      final item = BookPageItem(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 100),
          reverseDuration: const Duration(milliseconds: 100),
        ),
        AnimatedBookStatus.dismissed as AnimatedBookStatus?,
        url,
      );
      allPages.add(item);
    }
    allPages = allPages.reversed.toList();
    currentPages = allPages.reversed.toList();
  }
}
