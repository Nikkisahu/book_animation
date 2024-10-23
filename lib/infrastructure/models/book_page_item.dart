import 'package:flutter/material.dart';

import '../../packages/book_widget/src/enums/animated_book_status.dart';

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
// class BookPageItem {
//   final AnimationController animationController;
//   final AnimatedBookStatus bookStatus;
//   final String? url;
//
//   BookPageItem(this.animationController, this.bookStatus, this.url);
// }
