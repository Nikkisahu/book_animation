// import 'dart:developer';
//
// import 'package:book_animation/packages/book_widget/animated_book_widget.dart';
// import 'package:book_animation/packages/book_widget/src/widgets/background_blur.dart';
// import 'package:flutter/material.dart';
//
// class AnimatedBookWidget extends StatefulWidget {
//   const AnimatedBookWidget({
//     required this.cover,
//     required this.size,
//     super.key,
//     this.padding = EdgeInsets.zero,
//     this.blurRadius = 4,
//     this.spreadRadius = 0.5,
//     this.backgroundBlurOffset = Offset.zero,
//     this.backgroundColor,
//     this.backgroundShadowColor,
//     required this.totalPages,
//     required this.thisPageIndex,
//     this.curve = Curves.linear,
//     this.animationDuration = const Duration(milliseconds: 500),
//     this.reverseAnimationDuration = const Duration(milliseconds: 500),
//     this.backgroundBorderRadius = BorderRadius.zero,
//     required this.onAnimationFinished, // Add the onAnimationFinished parameter
//   });
//
//   // Add this parameter to handle animation status completion or dismissal
//   final Function(AnimatedBookStatus status) onAnimationFinished;
//
//   final Widget cover;
//   final Size size;
//
//   final EdgeInsets padding;
//
//   final Color? backgroundColor;
//
//   /// The color of the shadow applied to the background.
//   final Color? backgroundShadowColor;
//
//   /// The blur radius applied to the background.
//   final double blurRadius;
//
//   /// How far the shadow is spread.
//   final double spreadRadius;
//
//   /// The offset of the background blur effect.
//   final Offset backgroundBlurOffset;
//
//   /// The animation curve used for opening/closing the book.
//   final Curve curve;
//
//   /// The duration of the opening animation.
//   final Duration animationDuration;
//
//   /// The duration of the closing animation.
//   final Duration reverseAnimationDuration;
//
//   /// The border radius applied to the background.
//   final BorderRadius backgroundBorderRadius;
//
//   final int totalPages;
//   final int thisPageIndex;
//
//   @override
//   State<AnimatedBookWidget> createState() => _AnimatedBookWidgetState();
// }
//
// class _AnimatedBookWidgetState extends State<AnimatedBookWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController = AnimationController(
//     vsync: this,
//     duration: widget.animationDuration,
//     reverseDuration: widget.reverseAnimationDuration,
//   )..addStatusListener(statusListener);
//
//   late Animation<double> animation = animationController.curvedAnimation(
//     curve: widget.curve,
//   );
//
//   AnimatedBookStatus bookStatus = AnimatedBookStatus.dismissed;
//   late Size size = widget.size;
//   late Widget cover = widget.cover;
//
//   late EdgeInsets padding = widget.padding;
//   late Color backgroundColor =
//       widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
//   late Color backgroundShadowColor = widget.backgroundShadowColor ??
//       context.defaultTextStyle.color!.withOpacity(0.075);
//   late double blurRadius = widget.blurRadius;
//   late double spreadRadius = widget.spreadRadius;
//   late Offset backgroundBlurOffset = widget.backgroundBlurOffset;
//   late BorderRadius backgroundBorderRadius = widget.backgroundBorderRadius;
//
//   void statusListener(AnimationStatus status) {
//     switch (status) {
//       case AnimationStatus.dismissed:
//         log("widget..${widget.totalPages}");
//         log("widget.cover.${widget.cover}");
//         bookStatus = AnimatedBookStatus.dismissed;
//         widget.onAnimationFinished(bookStatus); // Notify parent about dismissal
//         break;
//       case AnimationStatus.completed:
//         bookStatus = AnimatedBookStatus.completed;
//
//         // Notify parent about animation completion
//         if (widget.thisPageIndex == widget.totalPages - 1) {
//           widget.onAnimationFinished(bookStatus);
//         }
//         break;
//       case AnimationStatus.forward:
//       case AnimationStatus.reverse:
//         bookStatus = AnimatedBookStatus.animated;
//         break;
//     }
//   }
//
//   void onPressed() {
//     switch (bookStatus) {
//       case AnimatedBookStatus.dismissed:
//         log("widget..${widget.totalPages}");
//         log("widget.cover.${widget.cover}");
//         animationController.forward(from: 0);
//         break;
//       case AnimatedBookStatus.completed:
//         if (widget.thisPageIndex != widget.totalPages - 1) {
//           animationController.reverse(from: 1);
//         }
//         break;
//       case AnimatedBookStatus.animated:
//         break;
//     }
//   }
//
//   @override
//   void dispose() {
//     animationController
//       ..removeStatusListener(statusListener)
//       ..dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding,
//       child: SizedBox.fromSize(
//         size: size,
//         child: GestureDetector(
//           onTap: onPressed,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               BackgroundBlur(
//                 backgroundColor: backgroundColor,
//                 backgroundShadowColor: backgroundShadowColor,
//                 blurRadius: blurRadius,
//                 spreadRadius: spreadRadius,
//                 offset: backgroundBlurOffset,
//                 borderRadius: backgroundBorderRadius,
//               ),
//               AnimatedCoverWidget(
//                 listenable: animation,
//                 cover: cover,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:book_animation/packages/book_widget/animated_book_widget.dart';
import 'package:book_animation/packages/book_widget/src/widgets/background_blur.dart';
import 'package:flutter/material.dart';

/// A customizable animated book widget with
/// cover, content, and animation control.
///
class AnimatedBookWidget extends StatefulWidget {
  /// Creates an [AnimatedBookWidget] with fixed content.
  ///
  /// The [cover] is the widget representing the book cover.
  ///
  /// The [size] is the size of the book.
  ///
  /// The [content] is the fixed content inside the book.
  ///
  /// The [padding] is the padding around the book.
  ///
  /// The [blurRadius] is the blur radius applied to the background.
  ///
  /// The [spreadRadius] is how far the shadow is spread.
  ///
  /// The [backgroundBlurOffset] is the offset of the background blur effect.
  ///
  /// The [backgroundColor] is the background color of the book.
  ///
  /// The [backgroundShadowColor] is the color of the shadow
  /// applied to the background.
  ///
  /// The [curve] is the animation curve used for opening/closing the book.
  ///
  /// The [animationDuration] is the duration of the opening animation.
  ///
  /// The [reverseAnimationDuration] is the duration of the closing animation.
  ///
  /// The [backgroundBorderRadius] is the border radius
  /// applied to the background.
  ///
  AnimatedBookWidget({
    required this.cover,
    required this.size,
    super.key,
    this.padding = EdgeInsets.zero,
    this.blurRadius = 4,
    this.spreadRadius = 0.5,
    this.backgroundBlurOffset = Offset.zero,
    this.backgroundColor,
    this.backgroundShadowColor,
    required this.totalPages,
    required this.thisPageIndex,
    this.curve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 500),
    this.reverseAnimationDuration = const Duration(milliseconds: 500),
    this.backgroundBorderRadius = BorderRadius.zero,
  });

  /// Creates an [AnimatedBookWidget] with dynamic content
  /// using a builder function.
  ///
  /// The [cover] is the widget representing the book cover.
  ///
  /// The [size] is the size of the book.
  ///
  /// The [contentBuilder] is a function that builds
  /// the dynamic content inside the book.
  ///
  /// The optional [contentChild] is used as a
  /// fallback if [contentBuilder] is null.
  ///
  /// The [padding] is the padding around the book.
  ///
  /// The [blurRadius] is the blur radius applied to the background.
  ///
  /// The [spreadRadius] is how far the shadow is spread.
  ///
  /// The [backgroundBlurOffset] is the offset of the background blur effect.
  ///
  /// The [backgroundColor] is the background color of the book.
  ///
  /// The [backgroundShadowColor] is the color of the
  /// shadow applied to the background.
  ///
  /// The [curve] is the animation curve used for opening/closing the book.
  ///
  /// The [animationDuration] is the duration of the opening animation.
  ///
  /// The [reverseAnimationDuration] is the duration of the closing animation.
  ///
  /// The [backgroundBorderRadius] is the border
  /// radius applied to the background.
  const AnimatedBookWidget.builder({
    required this.cover,
    required this.size,
    required this.totalPages,
    required this.thisPageIndex,
    // required AnimatedBookContentBuilder contentBuilder,
    super.key,
    this.padding = EdgeInsets.zero,
    this.blurRadius = 4,
    this.spreadRadius = 0.5,
    this.backgroundBlurOffset = Offset.zero,
    this.backgroundColor,
    this.backgroundShadowColor,
    this.curve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 500),
    this.reverseAnimationDuration = const Duration(milliseconds: 500),
    this.backgroundBorderRadius = BorderRadius.zero,
  });

  /// The widget representing the book cover.
  final Widget cover;

  /// The delegate responsible for building the animated content.

  /// The size of the book.
  final Size size;

  /// Padding applied to the book.
  final EdgeInsets padding;

  /// The background color of the book.
  final Color? backgroundColor;

  /// The color of the shadow applied to the background.
  final Color? backgroundShadowColor;

  /// The blur radius applied to the background.
  final double blurRadius;

  /// How far the shadow is spread.
  final double spreadRadius;

  /// The offset of the background blur effect.
  final Offset backgroundBlurOffset;

  /// The animation curve used for opening/closing the book.
  final Curve curve;

  /// The duration of the opening animation.
  final Duration animationDuration;

  /// The duration of the closing animation.
  final Duration reverseAnimationDuration;

  /// The border radius applied to the background.
  final BorderRadius backgroundBorderRadius;

  final int totalPages;
  final int thisPageIndex;

  @override
  State<AnimatedBookWidget> createState() => _AnimatedBookWidgetState();
}

class _AnimatedBookWidgetState extends State<AnimatedBookWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: widget.animationDuration,
    reverseDuration: widget.reverseAnimationDuration,
  )..addStatusListener(statusListener);
  late Animation<double> animation = animationController.curvedAnimation(
    curve: widget.curve,
  );

  AnimatedBookStatus bookStatus = AnimatedBookStatus.dismissed;
  late Size size = widget.size;
  late Widget cover = widget.cover;

  // late AnimatedContentDelegate contentDelegate = widget.contentDelegate;
  late EdgeInsets padding = widget.padding;
  late Color backgroundColor =
      widget.backgroundColor ?? context.theme.scaffoldBackgroundColor;
  late Color backgroundShadowColor = widget.backgroundShadowColor ??
      context.defaultTextStyle.color!.withOpacity(0.075);
  late double blurRadius = widget.blurRadius;
  late double spreadRadius = widget.spreadRadius;
  late Offset backgroundBlurOffset = widget.backgroundBlurOffset;
  late BorderRadius backgroundBorderRadius = widget.backgroundBorderRadius;

  // void statusListener(AnimationStatus status) {
  //   switch (status) {
  //     case AnimationStatus.dismissed:
  //       bookStatus = AnimatedBookStatus.dismissed;
  //     case AnimationStatus.completed:
  //       bookStatus = AnimatedBookStatus.completed;
  //     case AnimationStatus.forward:
  //     case AnimationStatus.reverse:
  //       bookStatus = AnimatedBookStatus.animated;
  //   }
  // }

  void statusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        bookStatus = AnimatedBookStatus.dismissed;
        break;
      case AnimationStatus.completed:
        // Only mark as completed if thisPageIndex matches the last page
        if (widget.thisPageIndex == widget.totalPages - 1) {
          bookStatus = AnimatedBookStatus.completed;
          log('Animation completed on the last page: ${widget.thisPageIndex}');
        }
        break;
      case AnimationStatus.forward:
        print("return..forward");

      case AnimationStatus.reverse:
        print("return..reverse");
        bookStatus = AnimatedBookStatus.animated;
        break;
    }
  }

  void onPressed() {
    switch (bookStatus) {
      case AnimatedBookStatus.dismissed:
        log("animationController..Forward");
        log("widget..${widget.totalPages}");
        log("widget.cover.${widget.cover}");
        animationController.forward(from: 0);
      case AnimatedBookStatus.completed:
        log("animationController..completed");
        log("widget..${widget.totalPages}");
        log("widget.cover.${widget.cover}");
        animationController.reverse(from: 1);
      case AnimatedBookStatus.animated:
        break;
    }
  }

  @override
  void dispose() {
    animationController
      ..removeStatusListener(statusListener)
      ..dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedBookWidget oldWidget) {
    size = widget.size != size ? widget.size : size;
    cover = widget.cover != cover ? widget.cover : cover;
    // contentDelegate = widget.contentDelegate != contentDelegate
    //     ? widget.contentDelegate
    //     : contentDelegate;
    padding = widget.padding != padding ? widget.padding : padding;
    backgroundColor = widget.backgroundColor != backgroundColor
        ? widget.backgroundColor ?? backgroundColor
        : backgroundColor;
    backgroundShadowColor =
        widget.backgroundShadowColor != backgroundShadowColor
            ? widget.backgroundShadowColor ?? backgroundShadowColor
            : backgroundShadowColor;
    blurRadius =
        widget.blurRadius != blurRadius ? widget.blurRadius : blurRadius;
    spreadRadius = widget.spreadRadius != spreadRadius
        ? widget.spreadRadius
        : spreadRadius;
    backgroundBlurOffset = widget.backgroundBlurOffset != backgroundBlurOffset
        ? widget.backgroundBlurOffset
        : backgroundBlurOffset;
    animationController
      ..duration = widget.animationDuration != oldWidget.animationDuration
          ? widget.animationDuration
          : animationController.duration
      ..reverseDuration =
          widget.reverseAnimationDuration != oldWidget.reverseAnimationDuration
              ? widget.reverseAnimationDuration
              : animationController.reverseDuration;
    animation = oldWidget.curve != widget.curve
        ? animationController.curvedAnimation(curve: widget.curve)
        : animation;
    backgroundBorderRadius =
        oldWidget.backgroundBorderRadius != widget.backgroundBorderRadius
            ? widget.backgroundBorderRadius
            : backgroundBorderRadius;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox.fromSize(
        size: size,
        child: GestureDetector(
          onTap: onPressed,
          child: Stack(
            fit: StackFit.expand,
            children: [
              BackgroundBlur(
                backgroundColor: backgroundColor,
                backgroundShadowColor: backgroundShadowColor,
                blurRadius: blurRadius,
                spreadRadius: spreadRadius,
                offset: backgroundBlurOffset,
                borderRadius: backgroundBorderRadius,
              ),
              // AnimatedContentWidget(
              //   bookAnimation: animation,
              //   delegate: contentDelegate,
              // ),
              AnimatedCoverWidget(
                listenable: animation,
                cover: cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
