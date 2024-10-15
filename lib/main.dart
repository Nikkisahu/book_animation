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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int currentPage = 0;
  final int totalPages = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (currentPage < totalPages - 1) {
      setState(() {
        currentPage++;
      });
      _controller.forward(from: 0.0);
    }
  }

  void _goToPreviousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      _controller.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 400,
              child: Stack(
                children: [
                  // Book pages
                  for (int i = 0; i < totalPages; i++)
                    if (i == currentPage)
                      _buildFlippingPage(i)
                    else
                      _buildStaticPage(i),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: currentPage > 0 ? _goToPreviousPage : null,
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed:
                      currentPage < totalPages - 1 ? _goToNextPage : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticPage(int pageNumber) {
    return Container(
      width: 300,
      height: 400,
      color: Colors.white,
      child: Center(
        child: Text(
          'Page ${pageNumber + 1}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildFlippingPage(int pageNumber) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double value = _controller.value;
        final Matrix4 transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(pi * value);

        return Transform(
          transform: transform,
          alignment: Alignment.centerLeft,
          child: Container(
            width: 300,
            height: 400,
            color: Colors.white,
            child: Center(
              child: Text(
                value < 0.5
                    ? 'Page ${pageNumber + 1}'
                    : 'Page ${pageNumber + 2}',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
    );
  }
}
