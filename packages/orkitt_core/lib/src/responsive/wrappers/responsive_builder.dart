import 'package:flutter/material.dart';
import 'package:orkitt_core/orkitt_core.dart';
import 'package:orkitt_core/src/model/composer.dart';

import '../effects/responsive_effect.dart';

class ResponsiveBuilder extends StatefulWidget {
  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.transition = ResponsiveTransition.fade,
    this.duration = const Duration(milliseconds: 300),
  });

  final ResponsiveTransition transition;
  final Duration duration;

  /// Builder provides a [Composer] object with full responsive info.
  final Widget Function(Composer ui) builder;

  @override
  State<ResponsiveBuilder> createState() => _ResponsiveBuilderState();
}

class _ResponsiveBuilderState extends State<ResponsiveBuilder> {
  late Composer _layoutData;
  String _generateKey(Composer data) {
    return '${data.isMobile
            ? "mobile"
            : data.isTablet
            ? "tablet"
            : "desktop"}'
        '_${data.isLandscape ? "landscape" : "portrait"}';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _layoutData = Composer.fromThis(context);
  }

  @override
  Widget build(BuildContext context) {
    _layoutData = Composer.fromThis(context);

    return AnimatedSwitcher(
      duration: widget.duration,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: ResponsiveTransitionBuilder.resolve(widget.transition),
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.center,
        children: [...previousChildren, if (currentChild != null) currentChild],
      ),
      child: KeyedSubtree(
        key: ValueKey(_generateKey(_layoutData)),
        child: widget.builder(_layoutData),
      ),
    );
  }
}

class ResponsiveSliver extends StatelessWidget {
  final Widget Function(Composer media) builder;
  final Duration duration;
  final ResponsiveTransition transition;

  const ResponsiveSliver({
    super.key,
    required this.builder,
    this.duration = const Duration(milliseconds: 300),
    this.transition = ResponsiveTransition.slide,
  });

  @override
  Widget build(BuildContext context) {
    final media = Composer.fromThis(context);
    return SliverToBoxAdapter(
      child: AnimatedSwitcher(
        duration: duration,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: ResponsiveTransitionBuilder.resolve(transition),
        layoutBuilder: (currentChild, previousChildren) => Stack(
          alignment: Alignment.center,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        ),
        child: KeyedSubtree(
          key: ValueKey(
            '${media.isMobile
                ? "mobile"
                : media.isTablet
                ? "tablet"
                : "desktop"}_${media.isLandscape ? "landscape" : "portrait"}',
          ),
          child: builder(media),
        ),
      ),
    );
  }
}
