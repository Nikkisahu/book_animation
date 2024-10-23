import 'package:book_animation/infrastructure/models/book_page_item.dart';
import 'package:book_animation/packages/book_widget/animated_book_widget.dart';
import 'package:flutter/foundation.dart';
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
  List<String> urls = [
    'https://i.pinimg.com/originals/a1/f8/87/a1f88733921c820db477d054fe96afbb.jpg',
    'https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg',
    'https://content.wepik.com/statics/90897927/preview-page0.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw51g1gMBrZN3FbN17flaY_YSYmTMGuudh3Q&s',
    'https://marketplace.canva.com/EAFf0E5urqk/1/0/1003w/canva-blue-and-green-surreal-fiction-book-cover-53S3IzrNxvY.jpg'
  ];
  bool _isFirstTap = true;

  @override
  void initState() {
    initializePages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 250,
            width: 15,
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
  }

  Widget buildRecursive() => Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        alignment: Alignment.centerRight,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          ...buildPagesList(currentPages.toList()),
        ],
      );

  List<Widget> buildPagesList(List<BookPageItem> pages) => List.generate(
        pages.length,
        (index) => AnimatedBookWidget(
            totalPages: pages.length,
            thisPageIndex: index,
            size: Size.fromWidth(MediaQuery.of(context).size.width * 0.5),
            cover: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(10), left: Radius.circular(10)),
              child: Image.network(
                pages[index].url ?? "",
                fit: BoxFit.cover,
              ),
            ),
            onAnimationFinished: (status) {
              final thisPage = pages[index];
              var originalIndex = pages.indexOf(thisPage);

              if (kDebugMode) {
                print("original index : $originalIndex");
              }
              switch (status) {
                case AnimatedBookStatus.dismissed: //1 for page close logic
                  allPages = pages.toList();

                  final openedPages = pages
                      .sublist(
                        originalIndex,
                        pages.length,
                      )
                      .reversed
                      .toList();
                  final closedPages = pages.sublist(0, originalIndex).toList();
                  currentPages =
                      currentPages = [...closedPages, ...openedPages];
                  if (kDebugMode) {
                    print(
                        'closed on dismissed: ${closedPages.map((e) => currentPages.indexOf(e)).toList()}'
                        '\nopen on dismissed: ${openedPages.map((e) => currentPages.indexOf(e)).toList()}'
                        '\nfinal on dismissed: ${currentPages.map((e) => currentPages.indexOf(e)).toList()}');
                  }
                  setState(() {});
                  break;
                case AnimatedBookStatus.completed: // for page open logic
                  currentPages = pages.toList();

                  final openedPages = pages
                      .sublist(
                        originalIndex,
                        pages.length,
                      )
                      .reversed
                      .toList();
                  final closedPages = pages.sublist(0, originalIndex).toList();
                  currentPages =
                      currentPages = [...closedPages, ...openedPages];
                  if (kDebugMode) {
                    print(
                        'closed on completed: ${closedPages.map((e) => currentPages.indexOf(e)).toList()}'
                        '\nopen on completed: ${openedPages.map((e) => currentPages.indexOf(e)).toList()}'
                        '\nfinal on completed: ${currentPages.map((e) => currentPages.indexOf(e)).toList()}');
                  }
                  if (_isFirstTap) {
                    _isFirstTap = false;
                  }
                  setState(() {});
                case AnimatedBookStatus.animated:
                default:
                  break;
              }
            }),
      );

  void initializePages() {
    for (String url in urls) {
      final item = BookPageItem(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 100),
          reverseDuration: const Duration(milliseconds: 100),
        ),
        AnimatedBookStatus.dismissed,
        url,
      );
      allPages.add(item);
    }
    allPages = allPages.reversed.toList();
    currentPages = allPages.toList();
  }
}
