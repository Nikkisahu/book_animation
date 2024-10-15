import 'dart:math';

import 'package:book_animation/show_book_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: BookFlipPage(),
    );
  }
}

class BookFlipPage extends StatefulWidget {
  @override
  _BookFlipPageState createState() => _BookFlipPageState();
}

class _BookFlipPageState extends State<BookFlipPage>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  int currentPage = 0;
  final int totalPages = 6;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      totalPages - 1,
      (_) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _goToNextPage() {
    if (currentPage < totalPages - 1) {
      _controllers[currentPage].forward();
      setState(() {
        currentPage++;
      });
    }
  }

  void _goToPreviousPage() {
    if (currentPage > 0) {
      _controllers[currentPage - 1].reverse();
      setState(() {
        currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: GestureDetector(
          onTapUp: (details) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final localPosition = box.globalToLocal(details.globalPosition);
            if (localPosition.dx > box.size.width / 2) {
              _goToNextPage();
            } else {
              _goToPreviousPage();
            }
          },
          child: SizedBox(
            width: 600,
            height: 400,
            child: Stack(
              children: [
                for (int i = 0; i < totalPages; i++) _buildPage(i),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int pageNumber) {
    bool isRightPage = pageNumber.isOdd;
    return Positioned(
      left: isRightPage ? 300 : 0,
      child: AnimatedBuilder(
        animation:
            pageNumber == 0 ? _controllers[0] : _controllers[pageNumber - 1],
        builder: (context, child) {
          final double value = pageNumber == 0
              ? _controllers[0].value
              : (isRightPage
                  ? 1 - _controllers[pageNumber - 1].value
                  : _controllers[pageNumber - 1].value);
          final double angle = isRightPage ? (pi * (1 - value)) : (pi * value);

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment:
                isRightPage ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Front side of the page
                  Opacity(
                    opacity: isRightPage ? 1 - value : value,
                    child: Center(
                      child: Text(
                        'Page ${pageNumber + 1}',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  // Back side of the page
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: Opacity(
                      opacity: isRightPage ? value : 1 - value,
                      child: Center(
                        child: Text(
                          'Page ${pageNumber + 1}',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
