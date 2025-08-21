import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedFlipContainer extends StatefulWidget {
  const AnimatedFlipContainer({
    super.key,
    required this.frontChild,
    required this.backChild,
    this.duration = const Duration(milliseconds: 600),
    this.isFlipped = false,
    this.onFlipComplete,
  });

  final Widget frontChild;
  final Widget backChild;
  final Duration duration;
  final bool isFlipped;
  final VoidCallback? onFlipComplete;

  @override
  State<AnimatedFlipContainer> createState() => _AnimatedFlipContainerState();
}

class _AnimatedFlipContainerState extends State<AnimatedFlipContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _flipAnimation;
  bool _isShowingFront = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _flipAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.addListener(() {
      if (_animationController.value >= 0.5 && _isShowingFront) {
        setState(() {
          _isShowingFront = false;
        });
      } else if (_animationController.value < 0.5 && !_isShowingFront) {
        setState(() {
          _isShowingFront = true;
        });
      }
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.onFlipComplete?.call();
      }
    });

    // Set initial state based on isFlipped
    if (widget.isFlipped) {
      _animationController.value = 1.0;
      _isShowingFront = false;
    }
  }

  @override
  void didUpdateWidget(AnimatedFlipContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped != oldWidget.isFlipped) {
      if (widget.isFlipped) {
        flip();
      } else {
        flipBack();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void flip() {
    if (!_animationController.isAnimating) {
      _animationController.forward();
    }
  }

  void flipBack() {
    if (!_animationController.isAnimating) {
      _animationController.reverse();
    }
  }

  void toggleFlip() {
    if (_animationController.isCompleted) {
      flipBack();
    } else {
      flip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) {
        final isShowingFront = _flipAnimation.value < 0.5;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_flipAnimation.value * math.pi),
          child: isShowingFront
              ? widget.frontChild
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(math.pi),
                  child: widget.backChild,
                ),
        );
      },
    );
  }
}
