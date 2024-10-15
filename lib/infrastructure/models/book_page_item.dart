import 'package:animated_book_widget/animated_book_widget.dart';
import 'package:flutter/material.dart';

class BookPageItem {
  AnimationController? animationController;

  AnimatedBookStatus? animatedBookStatus;
  String? url;

  BookPageItem(
    this.animationController,
    this.animatedBookStatus,
    this.url,
  );
}
